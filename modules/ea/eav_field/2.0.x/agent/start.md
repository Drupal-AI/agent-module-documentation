<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EAV Field (eav_field) — agent index

**Entity-Attribute-Value field: one `eav` field on a bundle holds many admin-defined attributes, stored in a dedicated `eav_value` entity and matched to hosts by taxonomy category.**

- **Version:** 2.0.x
- **Core:** ^10 || ^11 || ^12 || ^13 || ^14 || ^15 (php 8.3)
- **Dependencies:** entity, field, text, options
- **Key entities:** `eav_attribute` (definition), `eav_value` (values); custom storage `EavAttributeStorage` / `EavValueStorage`.
- **Key routes:** `/admin/structure/eav/attributes` (list/add/edit/delete/storage/field/widget/formatter settings); dynamic `entity.{type}.edit_eav` at `{canonical}/edit-eav/{field_name}`.
- **Permission:** `administer eav attributes` (all admin routes); edit-eav tab requires host `{type}.update` access.
- **Plugins:** Field type/widget/formatter `eav`, QueueWorker `DeleteEavValueEntities`, Search API processor, Devel Generate.

**Security:** admin attribute routes permission-gated; per-host EAV edit uses entity `update` access; storage uses entity/field query API and SqlContentEntityStorage (no raw SQL, no dynamic column concatenation) — no findings.

See [configure/eav_field.md](configure/eav_field.md) and [api/eav_field.md](api/eav_field.md).