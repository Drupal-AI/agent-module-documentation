<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Protected Download — agent index

Provides **HMAC-protected, time-limited file download links** (signed URLs: uri+expire+HMAC). Version **2.1.1**.
Core `^10.3||^11`.

Access/file-delivery — **sound**: public route but the controller **verifies the signature** (`SecurityKey::
verify` recomputes the HMAC, `hash_equals`, checks expiry) before serving. The link is a **capability** (deliver
securely, short expiry; HMAC key must stay secret). No per-user access role.
