<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Generate a Webform from a content type

Go to *Configuration → Content → Generate Webform*
(`/admin/config/content/webform-generator`). Requires `administer site configuration`.

1. **Select content type** (`WebformGeneratorForm`) → redirects to the field-select step.
2. **Select fields** (`/{bundle}/fields`, `WebformFieldSelectForm`) — tick the content-type
   fields to include. Backed by `WebformGeneratorService::buildElements($bundle, $fields)`,
   which loads `field_config` for `node`/`$bundle`, skips deleted fields, and maps each via
   `FieldMapperService::map()`.
3. **Preview** (`/{bundle}/preview`, `WebformPreviewForm`) — shows the mapped elements, then
   creates/updates the Webform (`WebformGeneratorService` generate/update; `$webform_id`).

Only node-bundle `field_config` (configurable) fields are mapped — base fields are not
included. Refine the result in the standard Webform build UI.
