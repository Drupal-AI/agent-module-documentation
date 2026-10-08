<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bamboo Twig — agent index

A suite of Twig extensions for Drupal templates, split into a parent + **9 submodules** enabled
à la carte. No config UI, no permissions, no Drush, no routes. The **parent module registers no
Twig function** — it only ships the private base service `bamboo_twig.twig.base`
(`TwigExtensionBase`) that every submodule extends for lazy service injection.

- **Catalogue of every Twig function/filter and which submodule provides it** →
  [theming/functions.md](theming/functions.md)
- **`TwigExtensionBase`: the base service, its lazy getters, and how to write your own extension** →
  [api/base.md](api/base.md)

Each submodule has its own nested doc tree under `modules/bamboo_twig/modules/<sub>/6.0.x/`:

- `bamboo_twig_cacheable` — `bamboo_attach_cacheable_metadata`
- `bamboo_twig_config` — `bamboo_config_get`, `bamboo_settings_get`, `bamboo_state_get`
- `bamboo_twig_extensions` — Twig-Extensions Text/Date/Array filters
- `bamboo_twig_file` — `bamboo_file_url_absolute`, `bamboo_file_extension_guesser`
- `bamboo_twig_i18n` — `bamboo_i18n_current_lang`, `bamboo_i18n_format_date`, `bamboo_i18n_get_translation`
- `bamboo_twig_loader` — `bamboo_load_*` + `bamboo_render_*`
- `bamboo_twig_path` — `bamboo_path_system`
- `bamboo_twig_security` — `bamboo_has_permission(s)`, `bamboo_has_role(s)`
- `bamboo_twig_token` — `bamboo_token`

Enable only what you use: `drush en bamboo_twig_loader -y`. Functions become available in any
`.html.twig`.
