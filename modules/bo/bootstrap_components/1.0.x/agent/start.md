<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bootstrap Components (bootstrap_components) — agent index

Lightweight Bootstrap 5 **Single Directory Components (SDC)** library for Drupal 10/11 (`core_version_requirement: ^10 || ^11`, package "User Interface"). Slimmer, easier-to-audit subset inspired by `ui_suite_bootstrap`.

## What it provides
- **21 SDC components** under `components/<name>/<name>.component.yml` + `<name>.twig`: accordion, accordion_item, alert, blockquote, breadcrumb, button, card, card_body, card_group, card_overlay, carousel, carousel_item, close_button, dropdown, modal, nav, navbar, navbar_nav, offcanvas, pagination, tooltip. Referenced as `bootstrap_components:<name>`.
- **One Twig extension** — `AttributesToolTwigExtension` (service `bootstrap_components.twig.attributes_tool`) registering a `to_attributes` filter AND function.
- Small behavior JS via `libraryOverrides` on `accordion` (js/accordion.js, deps core/drupal + core/once) and `carousel`; `tooltip` has a built public JS/CSS bundle. Most components declare a "fake" `libraryOverrides` for sub-theme extension.
- Bundled `stories/*.story.yml` preview fixtures per component.

## What it does NOT provide
No routes, no permissions, no config objects/schema, no `configure` route, no entities, no blocks, no Drush, no module deps. Requires only Drupal core; assumes Bootstrap 5 CSS/JS + Popper are loaded by the theme.

## Install
`drush en bootstrap_components -y && drush cr`. Ensure Bootstrap 5 assets are present globally.

## Solution docs
- [Components: props, slots, invocation](components/overview.md) — how to invoke each SDC and the notable props/slots/variants.
- [`to_attributes` Twig helper](api/to_attributes.md) — the attribute-normalization filter/function.
