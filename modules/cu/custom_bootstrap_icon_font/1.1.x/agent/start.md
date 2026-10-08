<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Custom Bootstrap Icon Font (custom_bootstrap_icon_font) — agent index

**Generates a compact custom WOFF2 icon font + CSS from a selected subset of Bootstrap Icons / Font Awesome SVGs, via Fantasticon.**

- **Version:** 1.1.x
- **Core:** ^10 || ^11 — depends on `drupal:file`
- **Configure route:** `custom_bootstrap_icon_font.generate` → `/admin/config/media/bootstrap-icon-font` (permission `administer custom bootstrap icon font`, `restrict access: TRUE`)
- **Config:** `custom_bootstrap_icon_font.settings` (`icons`, `bootstrap_icons`, `fontawesome_icons`, `codepoints`, `font_name`, `generator_command`, `version`, source dirs)
- **Services:** `custom_bootstrap_icon_font.builder` (build service), Twig extension, Drush command (`drush.services.yml`)
- **Output:** `public://custom_bootstrap_icon_font/font/*.woff2/.css`; CSS auto-attached by `hook_page_attachments()`.
- **Security:** single admin route behind a dedicated restricted permission; no anonymous/mutating endpoints. Generator runs via Symfony `Process` with an **argv array** (no shell string) — no shell injection. `generator_command` is admin-set config.

See [configure/generate.md](configure/generate.md) and [drush/build.md](drush/build.md).