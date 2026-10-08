<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Sites overrides (sites_content_overrides) — agent index
**Per-site content overrides for entity content in a Sites-module multi-site, via a site-aware entity resolver + service decorators.**

- **Version:** 1.0.x (1.0.0-alpha1)
- **Core:** ^10 || ^11 · **Depends on:** form_decorator, navigation (+ the non-core `sites`/`sites_preview` stack)
- **Config route:** `sites_content_overrides.settings` → `/admin/config/sites/content-overrides` (`administer site configuration`)
- **Decorates:** `paramconverter.entity`, `entity.repository`; services `SiteAwareEntityResolver`, `SitesContentOverridesService`, route/config subscribers, hooks (wired with `@csrf_token`)
- **Submodules:** behaviors, content_moderation, layout_builder, revisions_ui

**Security:** No custom mutating routes beyond the admin config form (`administer site configuration`). `SitesOverridesParagraphAccessControlHandler` grants paragraph update/delete inside a site-override edit route, but only when `$site->contentAccess('update', parent, account)` passes (delegates to Sites per-site access; bypasses only the moderation `forbid()`). Override action links use `@csrf_token`. No findings. See [extend/architecture.md](extend/architecture.md).
