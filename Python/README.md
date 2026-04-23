Networking Lab (Python Sockets)

This repository contains a networking lab — a collection of Python scripts that demonstrate how to send data between programs over a network using TCP and UDP sockets.

🌐 Big Picture
Sender  ──────────────────►  Receiver
(client)    network/localhost   (server)

All scripts simulate how real-world networked applications (like file transfer tools or chat apps) work at a low level — using raw Python sockets only, without high-level libraries.

🧪 Mini Projects
🔁 1. TCP Echo Server

Files: tcp_echo_server.py, tcp_echo_client.py

The simplest example to understand socket communication
Client sends a message → Server receives it → Server sends it back
Works like a mirror (echo)
⚠️ Note: tcp_echo_client.py is currently empty (needs implementation)
📦 2. UDP File Transfer (Stop-and-Wait)

Files: udp_client.py, udp_server.py

Transfers a file from client to server using UDP
Implements Stop-and-Wait protocol:
Send one chunk → wait for ACK → send next chunk
If no ACK → retry (up to 5 times)
Uses a 1-bit sequence number (alternating 0 and 1)
Detects duplicate packets
Similar to how early data transfer systems (modems) worked
📁 3. UDP File Transfer (Sequence Numbers)

Files: udp_file_sender.py, udp_file_receiver.py

More advanced UDP-based file transfer
Uses a 32-bit increasing sequence number
Handles packet retransmission on timeout
Uses 0xFFFFFFFF as an end-of-transfer signal
Closer to real-world protocols like TFTP
🧵 Bonus: Threaded UDP Server

File: udp_server_threaded.py

Handles multiple clients simultaneously
Each request is processed in a separate thread
Echoes received data back to clients
Demonstrates basic server scalability