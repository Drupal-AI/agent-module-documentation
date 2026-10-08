<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Schema Markup Generator (ai_schema_markup_generator) — agent index

Generates Schema.org JSON-LD for nodes via OpenAI and emits it into the page head. Version **1.0.2**, version-dir `1.0.x`. Core `^10.3 || ^11`. Package: SEO. PHP 8.1+, OpenAI API key required.

## What it is
On install, adds two fields to every content type: `field_schema_json` (string_long, holds JSON-LD) and `field_schema_json_checkbox` (boolean opt-in). Saving a node with the checkbox on triggers an OpenAI call that builds and stores JSON-LD; node view attaches it as a `<script type="application/ld+json">` head tag. Also ships an admin settings form and a bulk batch generator.

## Dependencies
- Core only (Node, Field, File). No contrib modules, no libraries, no Composer requirements beyond `drupal/core`.

## Provides
- **Permission**: `administer ai schema markup generator` (`restrict access: TRUE`).
- **Routes** (`ai_schema_markup_generator.routing.yml`, both gated by that permission):
  - `ai_schema_markup_generator.admin_settings` → `/admin/ai-schema-markup-generator` (`AISchemaMarkupGeneratorConfigForm`).
  - `ai_schema_markup_generator.bulk_schema_markup_generator` → `/admin/ai-bulk-schema-markup-generator` (`AISchemaMarkupGeneratorBulkBatchForm`).
- **Service**: `ai_schema_markup_generator.schema_generator` → `Service\AISchemaMarkupGenerator` (OpenAI calls, prompt building, validation).
- **Hooks** (`Hook\AISchemaMarkupGeneratorHooks`, OO hook attributes + `.module` legacy shims): `preprocess_node` (head emit), `form_node_form_alter` (adds the Schema JSON group + submit handler).
- **Config**: `ai_schema_markup_generator.settings` (+ schema in `config/schema/`).

## Solution docs
- [Settings & configuration](config/settings.md)
- [Fields, node-form & head emit](fields/schema-json.md)
- [Generator service & bulk generation API](api/generator.md)
