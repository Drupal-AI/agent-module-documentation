<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Body Attributes (body_attributes) — agent index

Adds CSS **classes** or named **HTML attributes** to page zones (`html`, `body`, `header`,
`main`, `footer`, or a custom CSS selector) via rule-based config with per-path / per-node-type
visibility conditions. Package *User interface*. Core `^10.3 || ^11`, PHP `8.1`. License
GPL-2.0-or-later. Version 1.0.0. **No module dependencies declared** (uses core `node` and
`path_alias` at runtime).

- **The rule config entity, its form, zones, conditions, routes & the `administer body attributes`
  permission** → [config/rules.md](config/rules.md)
- **How rules actually reach the page — `hook_preprocess_html`, `hook_page_attachments` + JS, and
  the always-on data-\* event subscriber** → [api/rendering.md](api/rendering.md)

## What it actually is

- One config entity: **`body_attribute_rule`** (`config_prefix = rule`, `admin_permission =
  administer body attributes`) in `src/Entity/BodyAttributeRule.php`, extending
  `ConfigEntityBase`. Exported keys: `id, label, status, zone, weight, custom_selector,
  attribute_type, attribute_name, attribute_value, conditions`. Interface
  `BodyAttributeRuleInterface` (only declares `getZone()` / `getWeight()`).
- Entity handlers: list builder `Controller\BodyAttributeRuleListBuilder`, add/edit form
  `Form\BodyAttributeRuleForm`, delete via core `EntityDeleteForm`.
- One service: **`body_attributes.manager`** (`Service\BodyAttributesManager`) and one event
  subscriber **`body_attributes.subscriber`** (`EventSubscriber\BodyAttributesSubscriber`,
  `KernelEvents::RESPONSE`).
- One JS library `body_attributes/apply` (`js/body_attributes.js`, `Drupal.behaviors.bodyAttributes`).
- **No config schema** shipped (no `config/schema/`), no install file, no Drush, no plugin types.
  It *consumes* core Condition plugins (`plugin.manager.condition`) but provides none.
- `Form\BodyAttributesSettingsForm` exists but is **dead code** — not referenced by any route,
  entity handler, or service; references a `path` field that isn't part of the entity's
  `config_export`. Ignore it; the live form is `BodyAttributeRuleForm`.

## Routes & permission (`body_attributes.routing.yml`)

All four routes require **`administer body attributes`**:
- `entity.body_attribute_rule.collection` — `/admin/config/user-interface/body-attributes` (list,
  the `configure` link).
- `entity.body_attribute_rule.add_form` — `/admin/config/body-attributes/add`.
- `entity.body_attribute_rule.edit_form` — `/admin/config/body-attributes/{body_attribute_rule}`.
- `entity.body_attribute_rule.delete_form` — `/admin/config/body-attributes/{body_attribute_rule}/delete`.

(Note: the entity annotation's `links` point at `/admin/config/user-interface/body-attributes/...`
paths that differ from the routing file's `/admin/config/body-attributes/...` — the routing file
is authoritative for the add/edit/delete paths.)

## Zones — two delivery paths

- `html` / `body` → merged server-side into `html_attributes` / `attributes` in
  `body_attributes_preprocess_html()`.
- `header` / `main` / `footer` / `selector` → sent via `drupalSettings.bodyAttributes` in
  `body_attributes_page_attachments()` and applied by `js/body_attributes.js` (client-side).

See [api/rendering.md](api/rendering.md) for the exact mechanism and the automatic `data-*` tags.
