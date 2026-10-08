<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Alerts Kit (alerts) — agent index

A configuration kit: installing it imports an `alert` content type, an `alert_severity` taxonomy (one color per severity), and an `alerts` view for site-alert banners. No custom entities, routes, permissions, or services — it is configuration plus two small `hook_views_pre_render()` implementations.

- **Version:** 1.1.x (installed 1.1.1) · **Core:** `^9 || ^10 || ^11` · **Package:** Configuration Kits
- **Requires:** `link`, `taxonomy`, `views`, `add_content_by_bundle`, `color_field`
- **Composer:** `drupal/add_content_by_bundle:^1.2`, `drupal/color_field:^3.0`
- **Submodule:** `alerts_olivero` (Olivero styling + localStorage dismissal JS) — see `modules/alerts_olivero/1.1.x/`

## What it provides
- **Content type `alert`** (`config/install/node.type.alert.yml`): `body` (text_with_summary) + required `field_severity` (entity_reference → `alert_severity` term, cardinality 1). New revisions on.
- **Vocabulary `alert_severity`** with `field_color` (color_field). `alerts_install()` seeds Emergency/Warning/Notice terms.
- **View `alerts`** (`config/optional/views.view.alerts.yml`): `default` list, `page_1` at `/alerts`, `block_1` header banner (5 most recent). Access = `access content`. Header uses the `add_content_by_bundle` "Add Alert" link.
- **Hooks:** `alerts_views_pre_render()` (`alerts.module`) injects per-severity `<style>` background colors into the page head; `alerts_olivero_views_pre_render()` attaches the Olivero library.

## Solution docs
- `agent/config/kit.md` — the imported config: content type, vocabulary, fields, view displays, install seed, dependencies.
- `agent/theming/banners.md` — how banners render and are styled: the CSS-injection hook, the `block_1` rewrite template, the Olivero library + dismissal JS, and how to replicate in a custom theme.
