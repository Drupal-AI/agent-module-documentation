<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Castorcito Advanced Pack (castorcito_advancedpack) — agent index

Sub-module of **[Castorcito](../../../../1.2.x/agent/start.md)**. Ships advanced components as
**configuration** plus a bundled Swiper library (no new PHP plugins/services/routes). Package
`Castorcito`, version 1.2.1-beta5, core `^10.2 || ^11`, GPL-2.0-or-later.

## Dependency

- `castorcito:castorcito` only.

## What it provides

- **Config entities on install** (`config/install/`): the `advancedpack` `castorcito_category`
  plus `castorcito_component.advancedpack_swiper_js` (+ `_swiper_js_item`) and
  `advancedpack_timeline` (+ `_timeline_item`).
- **SDCs** (`components/advancedpack_swiper_js/`, `components/advancedpack_timeline/`): the
  rendered markup for the slider and timeline. Override with
  `replaces: 'castorcito_advancedpack:<name>'` from a theme.
- **Library** (`castorcito_advancedpack.libraries.yml`): `swiperjs` — bundled
  `assets/lib/swiperjs/swiper-bundle.{js,css}`, depending on core/drupal, core/jquery,
  core/drupalSettings.
- **Hooks**: `hook_help`; uninstall-confirm warning
  (`castorcito_advancedpack_form_system_modules_uninstall_confirm_form_alter`);
  `hook_uninstall` (`castorcito_advancedpack.install`) deletes the `advancedpack` category and
  every component in it.

No permissions, routes, services, config schema, or Drush commands of its own.

## Usage

Enable it, then use the *Advanced pack* category components at `/admin/castorcito/component` via
the Castorcito widget/formatter on a JSON field. Clone before customising.
