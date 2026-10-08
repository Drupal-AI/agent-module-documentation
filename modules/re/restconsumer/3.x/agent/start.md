<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# REST Consumer (restconsumer) — agent index

Generic **REST client** for consuming external APIs (configurable outbound requests). Version **3.1.0**.

**Security:** it makes the **server** issue outbound requests — an **SSRF** surface if any URL is
user-controlled (keep URLs static/admin-set, allow-list dynamic destinations). Keep API credentials
out of plain config; use **TLS with verification** (don't disable cert checks).