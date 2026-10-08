# Node Title Validation — agent index

Attaches a `NodeTitleValidate` constraint to the node **title** base field on every bundle and
validates it against per-content-type rules stored in `node_title_validation.settings`. No plugin
types, no Drush. One admin form and one permission.

- **Config structure, rule keys per content type, drush read/write** →
  [configure/rules.md](configure/rules.md)
- **How validation works (constraint, validator logic, blocklist matching, uniqueness quirk)** →
  [api/validation.md](api/validation.md)

Key facts:
- Config route: `node_title_validation.admin_form` → `/admin/config/content/node-title-validation`,
  gated by permission **`node title validation admin control`** (not `administer nodes`).
- Config object `node_title_validation.settings`, key `node_title_validation_config` →
  `content_types.<bundle>.{exclude, comma, min, max, min-wc, max-wc, unique}` plus a top-level
  `unique`.
- The constraint is added in code (`_node_title_validation_add_constraint()`), so it fires on **any**
  node save that runs entity validation, not only the node form.
- Uniqueness quirk: the validator only checks uniqueness scoped to the node's own type via the
  per-type `unique` flag; the global `unique` toggle is stored but not enforced cross-type.
