<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Maintenance VIP Bypass — agent orientation

Cookie-based maintenance-mode bypass redeemed at `/vip/{token}`.

- Version 1.0.x, core ^10.
- `/vip/{token}` = `_access: TRUE` + `_maintenance_access: TRUE` → `VipController::grantAccess`. Guard: `if ($token !== $valid_token || empty($valid_token)) throw 503;` — strict compare AND empty-token check, so **no null/empty-default anonymous bypass**. Sets 24h HttpOnly cookie.
- Settings `/admin/config/development/maintenance-vip` gated `administer maintenance vip` (restricted).
- Only real weakness: token is a bearer secret in the URL, exact but non-constant-time compare; strength depends on admin choosing a long token. Low severity / by design.
