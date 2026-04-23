import socket
import sys

SERVER_IP = "127.0.0.1"
SERVER_PORT = 5005
CHUNK_SIZE = 512
TIMEOUT = 2
MAX_RETRIES = 5

def send_file(filename):
    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    sock.settimeout(TIMEOUT)

    seq = 0
    with open(filename, "rb") as f:
        while True:
            data = f.read(CHUNK_SIZE)
            if not data:
                break

            length = len(data)
            # Manual packet creation: [type][seq][length(2 bytes)][data]
            packet = bytes([0, seq]) + length.to_bytes(2, "big") + data

            retries = 0
            while retries < MAX_RETRIES:
                try:
                    sock.sendto(packet, (SERVER_IP, SERVER_PORT))
                    ack_packet, _ = sock.recvfrom(4)

                    ack_type = ack_packet[0]
                    ack_seq = ack_packet[1]

                    if ack_type == 1 and ack_seq == seq:
                        seq = 1 - seq
                        break
                except socket.timeout:
                    retries += 1
                    print(f"Timeout, retry {retries} for seq {seq}")
            else:
                print("Max retries reached, aborting transfer.")
                sock.close()
                return

   
    fin_packet = bytes([2, seq]) + (0).to_bytes(2, "big")
    sock.sendto(fin_packet, (SERVER_IP, SERVER_PORT))
    print("File transfer complete, FIN sent.")
    sock.close()

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python udp_client_simple.py <filename>")
        sys.exit(1)
    send_file(sys.argv[1])