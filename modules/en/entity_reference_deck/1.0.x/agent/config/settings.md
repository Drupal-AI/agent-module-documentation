<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Global settings form, config object & schema

## Route & permission

- Route `entity_reference_deck.settings` → `/admin/config/content/entity-reference-deck`
  (`entity_reference_deck.routing.yml`), form
  `Form/EntityReferenceDeckSettingsForm` (extends `ConfigFormBase`), `_admin_route: TRUE`.
- Requires permission **`administer entity reference deck`** (`restrict access: true`; declared in
  `entity_reference_deck.permissions.yml`). Menu link under *Configuration → Content authoring*
  (`entity_reference_deck.links.menu.yml`, parent `system.admin_config_content`).
- This is the module's only permission and its only route. There are no other custom routes,
  no state-changing GET endpoints, and no AJAX controllers in the core module.

## Config object `entity_reference_deck.settings`

Install defaults (`config/install/entity_reference_deck.settings.yml`); schema
`config/schema/entity_reference_deck.schema.yml` (`type: config_object`). Three top-level
sequences:

- `actions.<plugin_id>` → `{ enabled: bool, weight: int }` (defaults: moderation −10, usage 0,
  diff 10, preview_refresh 20, preview_toggle 30).
- `groups.<group_id>` → `{ weight: int }` (defaults: preview 0, default 10, meta 100).
- `meta_items.<plugin_id>` → `{ enabled: bool, weight: int }` (defaults: timestamps 0, editor 10).

The module also lists `entity_reference_deck.settings` under `config_devel` in its info.yml.

## Form behaviour (`EntityReferenceDeckSettingsForm`)

- Three tabledrag tables (Actions, Groups, Card meta) built from
  `EntityReferenceDeckSettingsResolver::discoverActionRows()` / `discoverGroupRows()` /
  `discoverMetaItemRows()`, which merge discovered plugin definitions with saved config so every
  currently-discovered plugin gets a row even before first save.
- Each checkbox/weight uses `#config_target` with a dotted path
  (`actions.<id>.enabled`, `actions.<id>.weight`, `groups.<id>.weight`,
  `meta_items.<id>.enabled`, `meta_items.<id>.weight`), so `ConfigFormBase::submitForm()` writes
  and saves without a custom submit loop. Labels are rendered via `#plain_text`.
- Config entries for plugins that are no longer discovered are simply not rendered — they are
  ignored, not deleted. New plugins fall back to their attribute-declared `weight`/`enabled` until
  saved.
- An action/meta item only ever renders when its plugin's `applies()` returns TRUE for the entity
  being displayed, regardless of the enabled setting here (the enabled flag can only hide, not
  force-show).

## Runtime resolution

`EntityReferenceDeckSettingsResolver::resolveSettings()` reads the three sequences into the shape
`EntityReferenceDeckContext` expects; `buildContext()` returns a context pre-populated with them.
Resolution is **global only** — there is no per-widget/per-field override layer in this version.
