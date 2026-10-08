<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform JSON Schema (webform_jsonschema) — agent index
**Exposes webforms as JSON Schema + UI Schema + Form Data via a REST resource for react-jsonschema-form.**

- **Version:** 2.0.x — core `^8 || ^9 || ^10`
- **Depends on:** webform (REST module must be enabled manually)
- **REST resource:** `webform_jsonschema` at `/webform_jsonschema/{webform_id}` — GET schema bundle, POST submission
- **Services:** `webform_jsonschema.transformer`, `webform_jsonschema.submission`, `serializer.encoder.webform_jsonschema`, route subscriber
- **Security:** access is governed by core REST permissions/config on the resource (no custom access override); submissions go through Webform's handling; no external calls. Ensure the resource's GET/POST permissions are scoped appropriately when enabling REST.

See [api/rest.md](api/rest.md).
