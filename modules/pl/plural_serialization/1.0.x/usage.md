<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Plural Variants Serialization serializes plural label variants as a clean sequence rather than a single string concatenated with the `\03` (PoItem) separator.

---

In Drupal, config values typed as `plural_label` store their singular/plural forms joined by a control-character delimiter, which produces ugly and diff-unfriendly YAML. This module registers a config `STORAGE_TRANSFORM_EXPORT`/`STORAGE_TRANSFORM_IMPORT` subscriber (`PluralSerializationConfigSubscriber`) that walks every config object's typed-data tree, and for any `plural_label` element explodes the delimited string into a YAML sequence on export and implodes it back on import — so the stored form stays a normal list while the runtime form is unchanged.

It solves a readability and version-control problem for multilingual sites: cleaner config diffs and hand-editable plural strings, with no change to how Drupal consumes the value at runtime. It exposes no routes, permissions, forms or user-facing UI — it operates entirely inside the config import/export pipeline. Typical use: install the module and export config; plural labels then appear as sequences in the YAML. Requires core ^10.5 (uses `PoItem::DELIMITER` and the storage-transform events).

---
- Produce cleaner YAML for plural label config
- Get readable config diffs for plural strings
- Hand-edit plural variants in exported config
- Avoid the `\03` separator in config files
- Transform plural labels on config export
- Restore the delimited form on config import
- Improve version control of multilingual config
- Keep runtime plural handling unchanged
- Serialize singular/plural forms as a sequence
- Review plural strings in code review more easily
- Standardize plural label storage across a team
- Support config-first multilingual workflows
- Apply the transform across all config collections
- Explode a delimited plural string on export
- Implode a plural sequence back on import
- Store singular and plural forms as separate list items
- Reduce merge conflicts on translated config
