<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commento Field (commento_field) — agent index

Adds a **field type** that embeds the [Commento](https://commento.io/) hosted comment
widget on an entity's canonical page. The field stores a single per-entity on/off flag
(`status`); the formatter, when the flag is on and the viewer has permission, prints the
Commento loader `<script>` plus a mount `<div id="commento">`. Package `Field types`. Core
`^9 || ^10 || ^11`. License GPL-2.0-or-later. Installed **1.0.0-beta5** (version dir `1.0.x`).
Not covered by Drupal's security advisory policy.

## Important: no server URL is configurable

The comment script is **hardcoded** to `https://cdn.commento.io/js/commento.js` — Commento's
hosted SaaS. There is **no setting to point it at a self-hosted Commento/Commento++ instance**;
the module always loads the public CDN script. The per-page comment thread is keyed by
`data-page-id`, which the formatter sets to the entity's **canonical URL**
(`$entity->toUrl('canonical')->toString()`). You associate the site by registering its domain in
your commento.io account, not through Drupal config.

## Dependencies

- No module or Composer dependencies (`composer.json` has no `require`; `.info.yml` has no
  `dependencies`). Uses only core Field API.

## What it provides (from source)

- **Field type** `commento` (`Plugin/Field/FieldType/CommentoItem`) — one `int` column `status`
  (`not null`, default `1`), main property `status`. `generateSampleValue()` returns a random 0/1.
- **Widget** `commento` (`Plugin/Field/FieldWidget/CommentoWidget`) — a single **checkbox**
  "Commento Comments" (default TRUE) whose `#access` is gated by `toggle commento comments`. It has
  **no widget settings form**.
- **Formatter** `commento` (`Plugin/Field/FieldFormatter/CommentoFormatter`) — renders a
  `#type => commento` render element when `status` is on **and** the viewer has
  `view commento comments`. Carries the display settings (see below).
- **Render element** `commento` (`Element/Commento`, `@RenderElement`) — `generatePlaceholder()`
  pre_render (again gated by `view commento comments`) emits the loader `<script>`, a
  `<div id="commento">` mount, and a `<noscript>` message.
- **Permissions** (`.permissions.yml`): `toggle commento comments`, `view commento comments`.
- **Config schema** (`.schema.yml`): defines `field.widget.settings.commento` only.
- **`.module`**: only `hook_help()`. No install/update hooks, no services, no routes, no central
  config form.

## Solution docs

- **Field type, widget, formatter/display settings, render element, permissions, config-schema note**
  → [config/settings.md](config/settings.md)
