<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Site Branding Per Role (site_branding_per_role) — agent index

**A Site Branding block whose logo link target is resolved per user role, with per-role toggles for logo/name/slogan.**

- **Version:** 1.0.x
- **Core:** ^8 || ^9 || ^10
- **Package:** Site Branding
- **Block:** `@Block(id='site_branding_per_role_block')` → `SiteBrandingPerRoleBlock`.
- **Config:** `access_site_logo`/`access_site_name`/`access_site_slogan` toggles, `logo_link[<role>]` URL per role.
- **Link resolution:** `getCurrentRoleLink()` — administrator → anonymous → non-default authenticated role → authenticated → `<front>`.
- **Theme:** `site_branding_per_role_block` (`block--site-branding-per-role-block.html.twig`).

**Security:** No routes/permissions/services; configuration is via the block form (placement gated by `administer blocks`). Per-role URLs are validated in `blockValidate()` (`isValid()` + must start with `#`/`?`/`/` or be `<front>`). Site name/slogan output as `#markup` from admin-controlled `system.site` config; logo URL from theme setting — no visitor-supplied input in the render path. `system.site` cache tags merged. No security findings.

See [configure/block.md](configure/block.md)
