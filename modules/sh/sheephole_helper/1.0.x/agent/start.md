<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Sheephole helper (sheephole_helper) — agent index
**Bridges Project Browser to a loopback desktop app that runs composer module installs over SSH.**

- **Version:** 1.0.x (1.0.0-alpha1)
- **Core:** ^10 || ^11 · **Depends on:** project_browser
- **Routes:** `sheephole_helper.online` → `/sheephole-helper/is-online`; `sheephole_helper.install` → `/sheephole-helper/install-module` — both `_permission: 'access content'`
- **Talks to:** `http://127.0.0.1:41295` (`/hurdy`, `/install-module`)

**Operational note:** `isOnline` answers only loopback callers (`getClientIp()` in [127.0.0.1, localhost]). Intended as a setup-time convenience; restrict or remove these routes post-setup.
