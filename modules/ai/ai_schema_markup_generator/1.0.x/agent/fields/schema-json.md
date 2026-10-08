<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Schema Markup Generator — fields, node form & head emit

Two constants (in `ai_schema_markup_generator.module`) name the fields created on install for every content type:
- `AI_SCHEMA_MARKUP_GENERATOR_FIELD` = `field_schema_json` (string_long) — stores the JSON-LD string.
- `AI_SCHEMA_MARKUP_GENERATOR_CHECKBOX` = `field_schema_json_checkbox` (boolean) — per-node opt-in.

## Node form
`Hook\AISchemaMarkupGeneratorHooks::formNodeFormAlter()` (`#[Hook('form_node_form_alter')]`) moves both fields into a `schema_json_group` details element inside the form's `advanced` sidebar group, defaults the checkbox on when the node's bundle is in `settings.content_types`, and appends `ai_schema_markup_generator_node_form_submit` to the submit handlers.

## On save
`ai_schema_markup_generator_node_form_submit()` (`.module`): if the checkbox is on, it calls `AISchemaMarkupGenerator::generateSchema($node)`, then `validateSchema()`. If validation returns `valid`, the generated schema is stored; otherwise the validation response is JSON-decoded and, if valid JSON, that corrected value is stored instead (via `_ai_schema_markup_generator_save_schema()`, which `json_encode`s arrays with `JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE` and saves the node). If the checkbox is off, `field_schema_json` is cleared and the node re-saved. (Note: this runs a node save inside the form submit handler, in addition to the normal form save.)

## Head emit (node view)
`Hook\AISchemaMarkupGeneratorHooks::preprocessNode()` (`#[Hook('preprocess_node')]`) reads `field_schema_json` and, when non-empty, attaches it to `$variables['#attached']['html_head']` as a render element:
```php
['#tag' => 'script', '#attributes' => ['type' => 'application/ld+json'], '#value' => $schema_value]
```
keyed `ai_schema_markup_generator_schema_json`. The value is rendered through Drupal core's `HtmlTag` render element (core handles the tag output), so the stored JSON-LD ends up inside a `<script type="application/ld+json">` tag in the page `<head>`.

## Editing
Because `field_schema_json` is a normal string_long field surfaced on the node form, anyone with edit access to the node can view and change the stored JSON-LD directly (not only the AI-generated value).
