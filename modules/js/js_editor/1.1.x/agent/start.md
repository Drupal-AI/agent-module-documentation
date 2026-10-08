<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Javascript Editor — agent index

Lets admins **add custom per-theme JavaScript via the browser** (runs on the front end). Gated by
`execute arbitrary js_editor scripts`. Version **1.1.0**. Core `^8||^9||^10||^11||^12`.

**SECURITY — dangerous by design:** custom JS runs in every visitor's browser, so that permission is
**effectively full site compromise** (steal sessions/credentials, deface, exfiltrate). Treat like
administer-filters/PHP — grant **only** to fully trusted admins, never editors.
