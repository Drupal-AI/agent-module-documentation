<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Frontpage Per Language (frontpage_per_lang) — agent index

**Defines a per-language front page path and resolves `/` to it at runtime on multilingual sites.**

- **Version:** 1.0.x
- **Core:** ^10 || ^11
- **Dependencies:** language
- **Package:** Multilingual
- **UI:** no own route — extends core Basic site settings (`/admin/config/system/site-information`, `administer site configuration`)
- **Config store:** `system.site` keys `page.front_<langid>` (hyphens stripped)
- **Services:** `frontpage_per_lang.language_front_page` (form element/validate/submit); `PathProcessorAlter` decorates `path_processor_front` (priority 10); `PathMatcherAlter` decorates `path.matcher`
- **Hooks:** `form_system_site_information_settings_alter`, `page_attachments` (hreflang links)

**Security:** no dedicated endpoints; config is written only through core's site-information form under `administer site configuration`. Per-language paths are validated (leading slash + `PathValidator`).

See [configure/settings.md](configure/settings.md)
