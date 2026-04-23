import socket
import struct
import time
import sys

DEST = (sys.argv[1], int(sys.argv[2]))
fname = sys.argv[3]

sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
sock.settimeout(0.5)

seq = 0

with open(fname, 'rb') as f:
    while True:
        chunk = f.read(1024)
        if not chunk:
            break

        pkt = struct.pack('!I', seq) + chunk

        while True:
            sock.sendto(pkt, DEST)
            try:
                data, _ = sock.recvfrom(8)
                (ack,) = struct.unpack('!I', data[:4])

                if ack == seq:
                    seq += 1
                    break

            except socket.timeout:
                print("Timeout, retransmit seq", seq)

# send end marker
sock.sendto(struct.pack('!I', 0xFFFFFFFF), DEST)
sock.close()
