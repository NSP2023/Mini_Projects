import socket

SERVER_IP = "127.0.0.1"
SERVER_PORT = 5005
OUTPUT_FILE = "received_file.txt"

def start_server():
    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    sock.bind((SERVER_IP, SERVER_PORT))
    print(f"Server listening on {SERVER_IP}:{SERVER_PORT}")

    expected_seq = 0

    with open(OUTPUT_FILE, "wb") as f:
        while True:
            packet, addr = sock.recvfrom(520)
            if len(packet) < 4:
                continue

            pkt_type = packet[0]
            seq = packet[1]
            length = int.from_bytes(packet[2:4], "big")
            data = packet[4:4 + length]

            if pkt_type == 0:  # Data packet
                if seq == expected_seq:
                    f.write(data)
                    expected_seq = 1 - expected_seq

                ack_packet = bytes([1, seq]) + (0).to_bytes(2, "big")
                sock.sendto(ack_packet, addr)

            elif pkt_type == 2:  # FIN packet
                print("FIN received. Transfer complete.")
                break

    sock.close()

if __name__ == "__main__":
    start_server()