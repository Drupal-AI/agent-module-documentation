<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Body Attribute Rules — config entity, form, conditions

Enable: `drush en body_attributes -y`. Manage at **Configuration → User Interface → Body
Attributes** (`/admin/config/user-interface/body-attributes`). Everything is gated by the
**`administer body attributes`** permission (`body_attributes.permissions.yml`), which is also the
entity's `admin_permission`.

## The `body_attribute_rule` config entity

`src/Entity/BodyAttributeRule.php` — a `ConfigEntityBase` (`config_prefix = rule`, so objects are
stored as `body_attributes.rule.<id>`). `config_export` fields and their defaults:

| Field | Default | Meaning |
|---|---|---|
| `id` / `label` | — | machine name / human label |
| `status` | `TRUE` | enabled; disabled rules are skipped at render time |
| `zone` | `body` | `html`, `body`, `header`, `main`, `footer`, or `selector` |
| `weight` | `0` | ordering (lower first); surfaced in the list builder |
| `custom_selector` | `''` | CSS selector, used only when `zone === selector` |
| `attribute_type` | `class` | `class` or `attribute` |
| `attribute_name` | `''` | HTML attribute name, used only when `attribute_type === attribute` |
| `attribute_value` | `''` | the class name (type `class`) or the attribute value (type `attribute`) |
| `conditions` | `[]` | serialized condition-plugin config (see below) |

Typed getters/setters exist for each (`getZone`, `getWeight`, `getAttributeType`,
`getAttributeName`, `getAttributeValue`, `getCustomSelector`, `getConditions`, plus setters).
**There is no config schema** (`config/schema/` is absent) — a real gap for translation/typed-data
but not a runtime blocker.

## Add/edit form — `Form\BodyAttributeRuleForm`

`src/Form/BodyAttributeRuleForm.php` (`final`, extends `EntityForm`; injects
`plugin.manager.condition`). Sections:

- **Basic Settings**: `label` (required), `id` (machine_name), `status` checkbox, `weight`.
- **Targeting**: `zone` select (required); `custom_selector` textfield shown only when
  `zone = selector` (via `#states`).
- **Attribute Configuration**: `attribute_type` select (`class` / `attribute`); `attribute_name`
  textfield shown only when `attribute_type = attribute`; `attribute_value` textfield (required).
- **Visibility Conditions** (`#tree`, collapsed): iterates `conditionManager->getDefinitions()`
  and renders each core Condition plugin's `buildConfigurationForm()`, **excluding**
  `current_theme`, `user_role`, `response_status`, and the `entity_bundle:*` plugins for
  block_content, comment, contact_message, media, taxonomy_term, shortcut, menu_link_content. In
  practice the usable conditions are **Request Path** (`request_path`) and **Content type**
  (`entity_bundle:node`).

`validateForm()`: requires `custom_selector` when `zone = selector`, and requires `attribute_name`
when `attribute_type = attribute`. `save()` maps each form value onto the entity, saves, shows a
status message, and redirects to the collection. Note `save()` writes `conditions` from the raw
`conditions_wrapper` form value (the plugins' own `submitConfigurationForm()` is **not** called),
so `conditions` is stored as the plugin form's nested array, matching what
`body_attributes_check_conditions()` reads.

## Condition matching — `body_attributes_check_conditions()`

In `body_attributes.module`. A rule with **no** path config and **no** node-bundle config is
treated as **Global (always applies)**. Otherwise it applies if **either** condition matches (OR
logic, not AND):

- **Path**: `conditions['request_path']['pages']` matched with `path.matcher` against both the
  current internal path and its alias (`path_alias.manager`). Supports wildcard patterns like
  `/blog/*`.
- **Node bundle**: `conditions['entity_bundle:node']['bundles']` compared to the current route's
  `node` parameter bundle (loads the node if the parameter is a scalar id).

If conditions are set but none match → the rule is skipped.

## Routes (`body_attributes.routing.yml`) — all require `administer body attributes`

- `entity.body_attribute_rule.collection` → `/admin/config/user-interface/body-attributes`
  (`_entity_list`, the `configure` link + admin menu item under *Configuration → User interface*).
- `entity.body_attribute_rule.add_form` → `/admin/config/body-attributes/add`.
- `entity.body_attribute_rule.edit_form` → `/admin/config/body-attributes/{body_attribute_rule}`.
- `entity.body_attribute_rule.delete_form` → `/admin/config/body-attributes/{body_attribute_rule}/delete`
  (core `EntityDeleteForm`).

List builder `Controller\BodyAttributeRuleListBuilder` shows columns Rule / Zone / Status / Weight.

## Config-export example (`body_attributes.rule.dark_theme.yml`)

```yaml
id: dark_theme
label: 'Dark theme flag'
status: true
zone: html
weight: 0
custom_selector: ''
attribute_type: attribute
attribute_name: data-theme
attribute_value: dark
conditions:
  request_path:
    pages: "/night/*"
  entity_bundle:node:
    bundles: {  }
```

For a class instead, set `attribute_type: class` and put the class name in `attribute_value`
(`attribute_name` is ignored for classes).
