<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Alerts Format (alerts_format) — agent index

Presentation-only companion for the **Alerts recipe**. Version **1.0.0-beta1**. Core
`^10 || ^11`. License GPL-2.0-or-later. Package **Recipes Support**.

## What it actually is

- **One hook, no more.** `alerts_format.module` implements only
  `alerts_format_views_pre_render(ViewExecutable $view)`. It acts **only** on the View whose
  `storage->id() == 'alerts'`.
- On that View it loads published terms of the **`alert_severity`** vocabulary
  (`entityTypeManager->getStorage('taxonomy_term')->loadByProperties(['vid' => 'alert_severity', 'status' => 1])`),
  reads each term's **`field_color`** (`$term->field_color->first()->getString()`), and attaches an
  inline `<style>` element to `#attached['html_head']` containing one
  `.alert-severity-<tid> { background: <color>; }` rule per term.
- **Provides nothing else**: no routes, no permissions, no services, no plugins, no config
  objects/schema, no Drush, no entities. No declared module dependencies in
  `alerts_format.info.yml` (it relies at runtime on core **views** + **taxonomy** and on the
  `alerts` View / `alert_severity` vocabulary / `field_color` field being present — the Alerts
  recipe supplies these).

## Details

- **The hook, its assumptions, and how to operate it** →
  [theming/severity-colors.md](theming/severity-colors.md)

## Submodule

- **Alerts Format - Olivero** (`alerts_format_olivero`) — attaches a CSS/JS library (full-width
  header banner styling + a client-side, `localStorage`-backed dismiss button) when the `alerts`
  View renders under the Olivero theme. Depends on `alerts_format`. Documented separately at
  [modules/alerts_format_olivero/1.0.x/agent/start.md](../../modules/alerts_format_olivero/1.0.x/agent/start.md).
