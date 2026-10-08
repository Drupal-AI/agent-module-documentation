<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Checkpost (checkpost) — agent index

**HTTP middleware gating a dev site by IP/CIDR/header/path allowlist.**

- **Version:** 1.0.x · **Core:** ^8 || ^9 || ^10
- **Config:** `checkpost.checkpost_settings` → `/admin/config/development/checkpost` (`administer site configuration`).
- **Service:** `http_middleware.checkpost` decorating the kernel (`CheckpostMiddleware`).

**Security:** admin-config-gated; the middleware itself is an access gate (403 by default when enabled). See [configure/checkpost.md](configure/checkpost.md).
