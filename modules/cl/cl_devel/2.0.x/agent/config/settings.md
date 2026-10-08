<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Install, enable & configuration

## Install / enable

- Composer: `composer require drupal/cl_devel` (pulls `league/commonmark ^2.4`), then
  `drush en cl_devel -y`.
- Requires Drupal core `^10.3 || ^11` with the core **SDC** subsystem (the `plugin.manager.sdc`
  service). No contrib module dependencies.
- Package `Components`. It is a **development aid** — enable it in dev, keep it out of production.

## Config object `sdc.settings`

- Install default: `config/install/cl_devel.settings.yml` ships `debug: false;` (a single boolean;
  note the file's literal trailing `;` is parsed by YAML as part of the scalar).
- Schema: `config/schema/cl_devel.schema.yml` declares:
  - `sdc.settings` — `config_object` with mapping `debug: boolean`.
  - `field.field_settings.cl_devel_style_selector` — field-instance settings mapping (`features`,
    `allowed`, `forbidden` sequences of strings) for a `cl_devel_style_selector` field type.
  - `field.value.cl_devel_style_selector` — default-value mapping (`module`, `variant` strings).
  - These `cl_devel_style_selector` schema entries describe a Fractal-style selector field; no
    matching field-type/widget plugin ships in this version's `src/` — they are schema only.

There is **no settings form** in this module. The `configure` link is null; the menu/task links
point at the read-only audit page (`cl_devel.registry`), not a config form. The `debug` flag has
no form UI here and is not read by the two controllers.

## What it does not provide

- No `*.permissions.yml` (reuses core `administer site configuration`).
- No `*.services.yml` (controllers get core services via `create()`).
- No `*.install` (no schema/update hooks).
- No Drush commands, no plugin types, no entities.
