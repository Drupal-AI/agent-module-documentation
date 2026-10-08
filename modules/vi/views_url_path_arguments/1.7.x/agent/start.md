<!-- SPDX-License-Identifier: GPL-2.0+ -->
# Views URL Path Arguments — agent index

Two Views plugins, both id **`views_url_path`**: an **argument default** and an **argument
validator** that convert a URL path alias in the address into the entity ID a contextual
filter needs. No configure route, no settings form, no permissions, no Drush, no services of
its own (it uses core `path_alias.repository`). All state lives inside a **view config
entity** (`views.view.<id>` → a display's `arguments.<id>`).

- **Use / configure the plugins on a view's contextual filter, options, and how resolution works** →
  [configure/views-arguments.md](configure/views-arguments.md)

Key facts:
- Enable on a contextual filter via **Provide default value → "Entity ID converted from URL
  path alias"** (`default_argument_type: views_url_path`) or **Specify validation criteria →
  "Entity ID from URL path alias"** (`validate.type: views_url_path`).
- Options (both plugins): `provide_static_segments` (bool) and `segments` (slash-free string
  prefix). Stored under `default_argument_options` / `validate.options.views_url_path`.
- Depends on `path_alias` + `views`. Config schema:
  `views.argument_default.views_url_path`, `views.argument_validator.views_url_path`.
