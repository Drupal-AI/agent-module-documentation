<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webform JSON Schema exposes Drupal webforms as JSON Schema, UI Schema and Form Data through a REST resource, so a decoupled front end (notably react-jsonschema-form) can render and submit them.

---

It registers a `@RestResource` (`webform_jsonschema`) at `/webform_jsonschema/{webform_id}`: GET returns the schema bundle for the webform, POST handles a submission. A `Transformer` service converts webform elements into JSON Schema (with per-element plugins implementing `JsonSchemaElementInterface`), a `Conditions` helper maps a subset of Drupal states to JSON Schema dependencies, and a route subscriber pins the content-type format to JSON. The REST module is not a declared dependency and must be enabled manually; per-webform "Custom properties" can override the generated uiSchema.

Operationally, access is governed by core REST configuration and permissions for the `webform_jsonschema` resource (e.g. via the REST UI) — there is no custom access bypass in the module. Submissions flow through Webform's own submission handling. No external calls; report-worthy surface is limited to whatever REST permissions the site grants on the resource.
---
- Serve a webform as JSON Schema at /webform_jsonschema/{id}
- Render a Drupal webform with react-jsonschema-form
- Return UI Schema alongside JSON Schema
- Return existing Form Data for a submission
- Accept submissions via POST to the REST resource
- Override ui:widget via a webform element's Custom properties
- Map webform conditions to JSON Schema dependencies
- Build a decoupled/React front end for Drupal webforms
- Enable the REST module and grant the resource permission
- Add per-element JSON Schema via element plugins
- Support multivalue elements (set empty items to 0)
- Expose validation constraints to the client schema
- Integrate webforms into a headless app
- Customize the encoder via the webform_jsonschema format
- Extend element transformation with hook (see api.php)
