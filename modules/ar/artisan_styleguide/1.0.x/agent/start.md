<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Artisan Styleguide (artisan_styleguide) — agent index

A living **style guide / SDC component showcase** for the Artisan theme. One admin page,
`/artisan-styleguide`, enumerates every **Single Directory Component (SDC)** registered on the
site and renders a preview of each from the component's own `examples`. Package `Artisan`.
Version **1.0.0**. Core `^10 || ^11`. License GPL-2.0-or-later.

- **The route, the builder service, the SDC preview mechanism, and the bundled reference
  component** → [api/builder.md](api/builder.md)

## What it actually is

- **One route**, `artisan_styleguide.preview` (`artisan_styleguide.routing.yml`): path
  `/artisan-styleguide`, permission **`administer themes`** (core admin permission — not a
  permission this module defines), controller
  `\Drupal\artisan_styleguide\Controller\ArtisanStyleguideController` (an invokable
  `ControllerBase`). It is also the module's `configure:` link.
- **One service**, `artisan_styleguide.builder` = `ArtisanStyleguideBuilder`
  (`implements ArtisanStyleguideBuilderInterface`), args `@renderer`, `@plugin.manager.sdc`.
  Overridable — swap in your own builder.
- **Two theme hooks** (`artisan_styleguide.module` → `hook_theme`): `artisan_styleguide`
  (vars `intro_notes`, `components`) and `artisan_styleguide__component` (vars `plugin_id`,
  `name`, `status`, `rendered`, `component`, `clarifications`). Templates in `templates/`.
- **One bundled SDC**, `artisan_styleguide:artisan-styleguide-sdc-model`
  (`components/artisan-styleguide-sdc-model/`) — a reference component exercising every prop
  type and slot kind; the builder weights it to the top of the listing.

## Dependencies

- Composer `require`: **`drupal/artisan` `^1.1`** (the Artisan theme).
- info.yml module dependency: core **`serialization`**.
- Runtime: core SDC (`plugin.manager.sdc`) — always present in Drupal 10.1+.

## What it does NOT provide

No entities, no fields, no config forms, **no config schema**, **no permissions of its own**,
no Drush, no plugin types, no libraries. It only reads component definitions and renders them.

## Mechanism (one line)

`build()` loops `pluginManagerSdc->getDefinitions()`, and for each definition
`componentDefinitionPreview()` maps the first `examples` entry of every prop/slot into a
`#type => component` array, `renderPlain()`s it, and reports OK/KO + clarifications. All example
data is developer-authored on-disk component metadata; there is no request input in the render.
