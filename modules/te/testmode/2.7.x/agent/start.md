<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Testmode — agent index

Alters **site content and configuration when running automated tests** (predictable/deterministic test
conditions). Config at `testmode.admin_settings`. Version **2.7.1**. Core `^10||^11`.

**Caveat — dev/testing tool:** by design it *alters content/config* when active — keep scoped to test/CI,
**ensure it's not active on production** (would change what visitors see). No access role.
