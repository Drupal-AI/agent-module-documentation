<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Security Login Secure (security_login_secure) — agent index

Brute-force protection (IP + account blocking on failed logins), by **miniOrange**. Version **3.0.1**.

Registration, API-key retrieval (`/rest/customer/key`) and the auth challenge call miniOrange's API (`xecurify.com`).

The brute-force feature itself is legitimate (usual IP-ban caveats: shared-IP false positives, real
client IP behind a proxy).