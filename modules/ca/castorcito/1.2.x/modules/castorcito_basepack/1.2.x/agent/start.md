<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Castorcito Base Pack (castorcito_basepack) — agent index

Sub-module of **[Castorcito](../../../../1.2.x/agent/start.md)**. Ships a library of ready-to-use
components as **configuration** (no new PHP plugins/services/routes). Package `Castorcito`,
version 1.2.1-beta5, core `^10.2 || ^11`, GPL-2.0-or-later.

## Dependency

- `castorcito:castorcito` only.

## What it provides

- **Config entities on install** (`config/install/`): the `basepack` `castorcito_category` plus
  `castorcito_component.*` entities: accordion, announcement_bar, banner, card, carousel
  (+ carousel_item), content, content_in_columns, data_number_card (+ item), icon,
  icons_in_columns, image, image_gallery (+ item), label, placed_block, quote, slide, slideshow,
  tabs, text, video.
- **SDCs** (`components/basepack_*/`): one Single Directory Component per rendered component,
  each with `.component.yml`, `.twig`, `.css` (and JS where needed). Override from a theme with
  `replaces: 'castorcito_basepack:<name>'`.
- **Hooks** (`castorcito_basepack.module`): `hook_help`; `hook_form_system_modules_uninstall_confirm_form_alter`
  (uninstall warning). `castorcito_basepack.install` `hook_uninstall` deletes the `basepack`
  category and every component in that category.
- **Libraries** (`castorcito_basepack.libraries.yml`): behaviour JS/CSS for interactive
  components (tabs/accordion/carousel/etc.).

No permissions, routes, services, config schema, or Drush commands of its own.

## Usage

Enable it, then find the components under the *Base pack* category at
`/admin/castorcito/component`; attach via the Castorcito widget/formatter on a JSON field
(see [../../../../1.2.x/agent/fields/widget-formatter.md](../../../../1.2.x/agent/fields/widget-formatter.md)).
Clone before customising.
