<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bootstrap Icons (bootstrap_icons) — agent index

Registers the **Bootstrap Icons** SVG library (2000+ icons) as a **Drupal core Icon API pack**
(`^11.1`, PHP `>=8.3`). Package **Media**, license GPL-2.0-or-later, version `0.0.1`, lifecycle
**experimental**. No hard module dependencies (relies only on core's Icon API / `svg` extractor).

Data-only integration: no routes, no permissions, no config schema/forms, no config entities, no
hooks, no JavaScript. The library SVGs are **not bundled** — installed separately to
`/libraries/bootstrap-icons/icons/`.

- **The icon pack, its extractor, template, `size` setting, and how to render/query icons** →
  [icons/pack.md](icons/pack.md)
- **Installing the SVG library (Drush command + Composer + manual)** →
  [install/library.md](install/library.md)

## What it actually is (from source)

- One icon-pack definition, `bootstrap_icons.icons.yml`, pack id **`bootstrap`**. Uses core's
  built-in **`svg` extractor**; `config.sources: /libraries/bootstrap-icons/icons/*.svg`. A `size`
  integer setting (default 24) and a Twig `template` wrapping icon SVG content in
  `class="bi bi-{{ icon_id|clean_class }}"`, `fill="currentColor"`, `aria-hidden="true"`.
- One PHP class: `BootstrapIconsCommands` (`src/Commands/BootstrapIconsCommands.php`, service
  `bootstrap_icons.commands` in `drush.services.yml`) — the Drush command
  **`bootstrap_icons:download`** (alias `bootstrap-icons-download`) that fetches + unpacks the
  upstream npm tarball. Not runtime code; admin CLI helper only.
- Library dep declared as `twbs/bootstrap-icons` `1.11.3` (via `composer.libraries.json` fragment,
  not `require` in `composer.json`).

## Render / query

- Twig: `{{ icon('bootstrap', 'arrow-right', {size: 24}) }}`.
- PHP render array: `['#type' => 'icon', '#pack_id' => 'bootstrap', '#icon_id' => 'house',
  '#settings' => ['size' => 24]]`.
- Programmatic: `\Drupal::service('plugin.manager.icon_pack')->getIcon('bootstrap:house')`.
