<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plural Variants Serialization (plural_serialization) — agent index

**Config storage transformer: writes `plural_label` values as a YAML sequence instead of a `\03`-concatenated string.**

- **Version:** 1.0.x (1.0.0-alpha3)
- **Core:** ^10.5 || ^11
- **Mechanism:** `PluralSerializationConfigSubscriber` on `ConfigEvents::STORAGE_TRANSFORM_EXPORT`/`IMPORT`; walks typed config, explode/implode `PoItem::DELIMITER` for `plural_label` elements across all collections.
- **Routes/permissions:** none.

**Security:** Operates only inside the config import/export pipeline; no routes, permissions, forms or HTTP surface. Runtime value handling is unchanged. No security findings.
