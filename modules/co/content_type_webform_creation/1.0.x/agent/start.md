<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Content Type Webform Creation (content_type_webform_creation) — agent index

**Wizard that generates a Webform from a node content type's fields.**

- **Version:** 1.0.x  **Core:** ^10.3 || ^11  **Depends:** webform
- **Routes (all `administer site configuration`):** `/admin/config/content/webform-generator` (pick type), `/{bundle}/fields` (select), `/{bundle}/preview` (preview + generate).
- **Services:** `WebformGeneratorService` (`buildElements`, generate/update) + `FieldMapperService` (field_config → Webform element).
- **Security:** admin-permission-gated config wizard; no anonymous or public endpoints.

See [configure/generate.md](configure/generate.md).
