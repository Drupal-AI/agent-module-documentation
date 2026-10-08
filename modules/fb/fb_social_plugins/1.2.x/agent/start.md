<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Facebook social plugins — agent orientation

D8/9/10 module adding Facebook Like/Share/Page/Comments as blocks and per-bundle extra fields.

- Config forms under `/admin/fb-social-plugins` gated by permission `access fb social plugins config` (restrict access: TRUE).
- `fb_social_plugins.module` implements `hook_entity_extra_field_info()` + `hook_ENTITY_TYPE_view()`; blocks in `src/Plugin/Block/`.
- Templates in `templates/*.html.twig` output config values (page URL, current URL, sizes) into `data-*` attributes.
- Security note (reviewed): Twig autoescaping applies to all `{{ }}` attribute output, and plugin settings are admin-only (restricted permission / block config). The reflected `current_url` is escaped in-attribute — no stored/reflected XSS found. Settings are trusted-admin input.
