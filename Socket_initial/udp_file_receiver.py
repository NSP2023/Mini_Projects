import socket
import struct
import sys

PORT = int(sys.argv[1])
out = sys.argv[2]

sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
sock.bind(('0.0.0.0', PORT))

with open(out, 'wb') as fo:
    expected = 0

    while True:
        data, addr = sock.recvfrom(2048)
        (seq,) = struct.unpack('!I', data[:4])

        if seq == 0xFFFFFFFF:
            print("Transfer complete")
            sock.sendto(struct.pack('!I', 0xFFFFFFFF), addr)
            break

        payload = data[4:]

        if seq == expected:
            fo.write(payload)
            sock.sendto(struct.pack('!I', seq), addr)
            expected += 1
        else:
            last_acked = expected - 1 if expected > 0 else 0
            sock.sendto(struct.pack('!I', last_acked), addr)

sock.close()