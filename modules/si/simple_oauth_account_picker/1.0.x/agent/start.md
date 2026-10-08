<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Simple OAuth Account Picker — agent index

**Adds an account picker to the Simple OAuth authorize endpoint**. Depends on `simple_oauth`. Version
**1.0.0-rc1**. Core `^10.3||^11`.

Authentication-flow — touches the sensitive **authorize** endpoint: verify it only lets the **authenticated user**
authorize their **own** account (not select/grant on behalf of another account = bypass), and that switching
accounts requires re-authentication and tokens bind to the authenticated session. No broader access role.
