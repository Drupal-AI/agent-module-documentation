<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the diagram — `erd.settings`

Form `EntityRelationshipDiagramSettingsForm` (`erd_settings`) at route `erd.settings`
(`/admin/structure/erd/settings`, gated by `administer erd`). It is a plain `FormBase`, not a
`ConfigFormBase`, and simply writes each submitted value into the mutable config object
`erd.settings`. There is **no `config/install` default and no `config/schema`** — the object
does not exist until the form is saved once, and saving it emits a "no schema" notice in the
Drupal log while still working. Before that first save, every read below falls back to the
controller defaults noted.

## Config keys (`erd.settings`)

| Key | Form field | Type | Default (controller/form) | Effect on the diagram |
|-----|-----------|------|---------------------------|-----------------------|
| `output_format` | radios "Poll status" | string `svg`\|`png` | `svg` | Format used by the client-side "Save to image" button. |
| `field_exclude` | textarea | string (comma-separated) | `''` | Field/property names to drop from every bundle. Split on `,` and trimmed. |
| `property_include` | textarea | string (comma-separated) | `''` (empty ⇒ include all) | Allow-list of property names to keep. When non-empty, a property is shown only if it is in this list **or** its name starts with `field_`. |
| `entity_reference_only` | checkbox | bool | `false` | When true, only `entity_reference`-typed fields are rendered; all other properties/fields are hidden. |

`getMainDiagram()` reads these as `$config->get('field_exclude')`, `->get('property_include')`,
`->get('entity_reference_only')`, `->get('output_format')` and applies the filtering while
walking every entity type and bundle. (The submit handler also inadvertently stores the submit
button under a `save` key; it is harmless and unused.)

## Set it via Drush

```bash
# Show only entity_reference fields, SVG export:
drush config:set erd.settings entity_reference_only 1 -y
drush config:set erd.settings output_format svg -y

# Hide two noisy fields, keep only a few properties:
drush config:set erd.settings field_exclude 'field_legacy, field_debug' -y
drush config:set erd.settings property_include 'title, body, created' -y
```

## Set it via PHP

```php
\Drupal::configFactory()->getEditable('erd.settings')
  ->set('output_format', 'svg')
  ->set('field_exclude', 'field_internal')
  ->set('property_include', '')
  ->set('entity_reference_only', TRUE)
  ->save();
```

Note: because there is no config schema, avoid `drush config:import` round-trips relying on
typed-data casting; store `entity_reference_only` as a boolean/`1` as shown.
