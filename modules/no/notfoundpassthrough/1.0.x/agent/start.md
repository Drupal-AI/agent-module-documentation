<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Page Not Found Passthrough — agent index

On a **404**, attempts configured **fallback domains** to find the content and redirect/serve it (migration
fallback so old URLs still resolve). Depends on `redirect`. Config at `notfoundpassthrough.settings`; provides
permissions. Version **1.0.0-beta6**. Core `^10||^11`.

**Security:** makes a **server-side request to the admin-configured fallback host(s)** on 404 (not open SSRF,
but keep the list to **trusted hosts** + HTTPS). No access role beyond permission.
