<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extra Block Types (EBT): Views (ebt_views) — agent index

**Adds an `ebt_views` block-content type that embeds an existing View (via Views Reference) as a styled EBT block.**

- **Version:** 2.0.x
- **Core:** ^10.1 || ^11 || ^12 · **Depends on:** ebt_core, viewsreference
- **Provides:** `block_content` bundle `ebt_views` with fields `field_ebt_views_views` (viewsreference), `body`, and `field_ebt_settings`; Twig templates + CSS for EBT styling.
- **Routes/permissions/services:** none of its own; uses core block_content + EBT Core.
- **Security:** Config/template-only; no routes, controllers or permissions. The embedded view enforces its own access. No findings.

See [configure/setup.md](configure/setup.md)
