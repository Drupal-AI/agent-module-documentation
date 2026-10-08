<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# REST resource & transformation

## Resource
`@RestResource(id="webform_jsonschema")` — `WebformJsonSchemaResource` (extends core `ResourceBase`).
- `canonical`/`create` URI: `/webform_jsonschema/{webform_id}`.
- `get($webform_id)` → JSON Schema + UI Schema + Form Data bundle.
- `post(...)` → creates a webform submission.
- Serialized with the custom `webform_jsonschema` format (encoder `JsonEncoder`).
- The REST module is **not** a declared dependency — enable it and configure the resource (method + auth + permission) via REST UI. Access control is standard core REST; the module adds none of its own.

## Transformation
- `Transformer` (`@module_handler`) walks webform elements; each element type maps via a plugin implementing `JsonSchemaElementInterface` (`WebformItem`, etc.).
- `Conditions` translates a limited subset of Drupal states into JSON Schema `dependencies` (see README limitations).
- Per-element override: add to a webform element's **Custom properties**:
  ```
  webform_jsonschema:
    uiSchema:
      'ui:widget': carSelector
  ```
- Extension point: `webform_jsonschema.api.php` documents hooks for altering the generated schema.
