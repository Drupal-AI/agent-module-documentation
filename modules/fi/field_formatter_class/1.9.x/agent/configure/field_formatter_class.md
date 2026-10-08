# Configure the Field Formatter Class setting

There is **no dedicated admin page and no configuration form of its own** — the module has no
`configure` route. Enabling `field_formatter_class` automatically adds one extra setting to
every field formatter and every field widget.

## Where to find it

1. Go to **Structure → [entity type] → Manage display** (e.g. `/admin/structure/types/manage/article/display`),
   or **Manage form** for the widget side.
2. Click the **gear / edit** icon on a field's row to open its formatter settings.
3. A **Field Formatter Class** textfield appears (formatter side: `#maxlength` 256). Type one or
   more space-separated CSS classes and **Update**, then **Save**.

The Manage display row summary then shows `Class: <value>` (added via
`hook_field_formatter_settings_summary_alter()`; the widget side has the equivalent).

## How it is stored

The value is saved as a **third-party setting** on the entity view display (or form display),
keyed by the module name:

```
third_party_settings:
  field_formatter_class:
    class: 'col-md-6 my-hook'
```

- Config schema: `config/schema/field_formatter_class.schema.yml` defines
  `field.formatter.third_party.field_formatter_class` and
  `field.widget.third_party.field_formatter_class`, each a mapping with a single `class` string.
- Because it lives on the display config entity, the class **exports/imports** with
  `drush config:export` / `config:import` like any other display setting — there is no separate
  config object to manage.

## Tokens

The setting supports **tokens**. The stored string is passed through `Token::replace()` at render
time (see [theming](../theming/field_formatter_class.md)), scoped to the field's target entity
type, so values like `[node:field_state]` resolve per entity. If the **Token** module is enabled,
a token-browser link is rendered next to the textfield.

## Requirements & scope

- Depends only on core **`field`**. (The Manage display/form UI itself is provided by core
  Field UI.) No permissions, no services, no Drush commands.
- Applies to **every** formatter/widget on **any** fieldable entity (nodes, users, taxonomy,
  media, etc.). Leaving the field blank is a no-op — no per-field setup is needed to install it.
- A bundled D7 migration (`migrations/d7_field_formatter_class.yml`) carries values forward from
  the Drupal 7 version.
