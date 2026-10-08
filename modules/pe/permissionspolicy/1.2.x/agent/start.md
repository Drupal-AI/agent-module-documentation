<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions Policy — agent index

Emits a site-wide `Permissions-Policy` HTTP header controlling which browser features
(camera, geolocation, microphone, fullscreen, autoplay, …) are allowed, for your origin and
embedded frames. Header value is built from config `permissionspolicy.settings`.

- **Config structure, feature keys, base/sources values, admin form** →
  [configure/policy.md](configure/policy.md)
- **How the header is built & serialized, the alter event, feature list** →
  [api/mechanism.md](api/mechanism.md)

Key facts:
- Configure route `permissionspolicy.settings` → `/admin/config/system/permissionspolicy`.
  Permission: `administer permissions policy configuration`.
- Config `permissionspolicy.settings` → `enforce.enable` (bool) + `enforce.features.<feature>`
  → `{ base: 'self'|'none'|'any'|'' , sources: ['https://example.com', ...] }`.
- Ships enabled with **empty** `features` → no header until you add features.
- Header serialization uses `gapple/structured-fields`. `self`→`(self)`, `none`→`()`,
  `any`→`*`. Example header: `geolocation=(self), camera=(), autoplay=*`.
- Extensible via `PolicyAlterEvent` (event name `permissionspolicy.policy_alter`). No Drush.
