# Xray Audit Drush commands

Source: `src/Drush/Commands/XrayAuditCommands.php` (auto-discovered from `src/Drush/Commands`;
commands declared with `@command` docblock annotations). All return a table-formatted array. They back the node/paragraph
"usage" reports so you can script them.

| Command | Args / options | Does |
|---|---|---|
| `xray_audit:node_count` | — | Counts nodes "in use" (criterion: `status = published`), grouped. Uses `xray_audit.entity_use_node`. |
| `xray_audit:paragraph_count` | — | Counts paragraph bundles that are used (referenced in published **and** unpublished entities). Uses `xray_audit.entity_use_paragraph`. |
| `xray_audit:usage_place` | arg `node`\|`paragraph`; `--bundles=a,b`; `--parents=a,b` | Lists the entities where the given node/paragraph bundles are used. `--bundles` = comma list of bundle machine names; `--parents` = comma list of parent entity types (defaults to `node`; ignored for the `node` arg). |

## Examples

```bash
ddev drush xray_audit:node_count
ddev drush xray_audit:paragraph_count
# Where are these two paragraph bundles used, under any parent node?
ddev drush xray_audit:usage_place paragraph --bundles=hero,cta --parents=node
```

Notes:
- `usage_place` validates the entity arg against `['node','paragraph']` and logs an error for
  anything else; empty `--bundles` becomes "all", empty `--parents` defaults to `node`.
- These commands only read data; they make no changes.
