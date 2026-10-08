<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Server IP — agent index

Displays the **server's IP address** (see which backend served a request — load-balanced debugging). Provides
permissions. Version **3.0.0**. Core `>=8`.

Admin/diagnostic — the IP is **infrastructure info**: gate to **trusted admins** (don't expose backend IPs
publicly). No access role beyond permission.
