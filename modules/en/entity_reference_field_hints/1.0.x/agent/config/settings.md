<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings, schema, and operation

## Install / enable

`drush en entity_reference_field_hints`. Requires only core `field`. No install hooks, no
`config/install`, no default config objects — enabling the module adds nothing until you turn hints
on for a specific widget.

## Where settings live

There is **no admin settings form and no `configure` route**. Configuration is per-widget
third-party settings stored on the form display, edited on each bundle's *Manage form display* page
(open a supported entity reference widget's gear/settings). They are namespaced under
`entity_reference_field_hints`.

## Setting keys and defaults

From `EntityReferenceHintSettings::defaults()` (`src/Service/EntityReferenceHintSettings.php`):

| Key | Type | Default | Meaning |
| --- | --- | --- | --- |
| `enabled` | boolean | `FALSE` | Master switch; when off, no hint is rendered. |
| `show_allowed_bundles` | boolean | `TRUE` | Render the "Allowed: …" line of target bundles. |
| `show_create_permissions` | boolean | `TRUE` | Render the "You can create: …" line (current user's create access). |
| `empty_allowed_text` | string | `Allowed: @target_type` | Fallback used when the field allows *all* bundles; `@target_type` is replaced with the target type's plural label. |

`forWidget()` merges stored settings over these defaults
(`$widget->getThirdPartySettings(self::MODULE) + $this->defaults()`), so any unset key falls back to
the default. `self::MODULE` is `entity_reference_field_hints`.

## Config schema

`config/schema/entity_reference_field_hints.schema.yml` defines
`field.widget.third_party.entity_reference_field_hints` (a `mapping`) with the four keys above:
`enabled` and `show_allowed_bundles`/`show_create_permissions` as `boolean`, and `empty_allowed_text`
as `label`.

## Operating notes

- The hint appears only on the entity edit form widget, not on the field's default-value widget
  (the `field_widget_complete_form_alter` handler returns early when `context['default']` is set).
- Only these widget element types receive the hint: `checkboxes`, `entity_autocomplete`, `radios`,
  `select` (see `isDescribableElement()`).
- The settings form only appears for supported fields: `entity_reference` /
  `entity_reference_revisions` targeting `media`, `node`, `paragraph`, `taxonomy_term`, or `user`.
- The *Manage form display* settings summary shows whether hints are enabled for the widget.
- A kernel test (`tests/src/Kernel/EntityReferenceFieldHintsTest.php`) asserts that a node field with
  target bundles `article`, `event` produces the line `Allowed: Article, Event`.
