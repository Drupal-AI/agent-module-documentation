<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Velocity (velocity) — agent index

**Integrates the Velocity.js accelerated animation engine (v1.5.2 / v2.0.6), local or CDN.**

- **Version:** 1.0.x (release 1.0.0-beta1)
- **Core:** ^8.8 || ^9 || ^10 || ^11
- **Libraries:** `velocity/velocity-v1.min.js`, `velocity/velocity.ui-v1.min.js`, v2 + `-cdn-` variants (see `velocity.libraries.yml`)
- **Base module:** `hook_page_attachments()` attaches v1 min + UI pack globally when `velocity_ui` is disabled (local if installed, else cdnjs CDN).
- **Submodule `velocity_ui`:** settings form `velocity.settings` at `/admin/config/user-interface/velocity/settings`, permission `administer velocity`; config object `velocity.settings` (load, pack, version, method, minimized.options, url.visibility, url.pages). Supports `?velocity=no` per-page opt-out.

**Security:** Admin config route permission-gated (`administer velocity`); no anonymous or mutating endpoints. Note the CDN library variants load third-party JS from cdnjs (supply-chain consideration); prefer the local method for locked-down sites.

See [configure/velocity-ui.md](configure/velocity-ui.md)
