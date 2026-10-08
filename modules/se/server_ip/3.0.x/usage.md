<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Server IP displays the IP address of the server.

---

Server IP **displays the server's IP address** — useful on load-balanced/multi-server setups to see which
backend served a request (debugging, cache/affinity checks). It provides its own permissions, core 8+.

Use it to check which server handled a request. It is an administration/diagnostic feature. Security note: the
server IP is **minor infrastructure information** — gate its display to **trusted admins** via its permission
(don't expose backend IPs publicly, as they can aid an attacker mapping your infrastructure). It has no
access-control role beyond its permission. Configure who can see the server IP.

---

- Display the server's IP.
- Show which backend served a request.
- Aid load-balanced debugging.
- Provide its own permissions.
- Check server affinity.
- Serve diagnostics.
- TREAT the IP as infrastructure info.
- Gate it to trusted admins.
- Not expose backend IPs publicly.
- Have no access-control role beyond permission.
- Configure who sees the IP.
- Handle the server IP.
- Show the IP.
- Configure the display.
- Display server info.
- Handle the diagnostic.
- Show backend IP.
- Report the IP.
- Restrict the display.
- Provide server IP display.
