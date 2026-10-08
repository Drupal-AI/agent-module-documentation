# Configure Islandora Breadcrumbs

## Settings form

Route `system.islandora_breadcrumbs_settings` → `/admin/config/islandora/breadcrumbs`
(`IslandoraBreadcrumbsSettingsForm`), requires `administer site configuration`. Writes config object
`islandora_breadcrumbs.breadcrumbs`:

| Key | Default | Meaning |
|---|---|---|
| `referenceFields` | `[field_member_of]` | Entity-reference field(s) that point to the parent node. The builder follows these upward. |
| `maxDepth` | `-1` | Maximum number of ancestors to include; `-1` = unlimited. |
| `includeSelf` | `FALSE` | Whether the current node is added as the final breadcrumb. |

```bash
drush cset islandora_breadcrumbs.breadcrumbs maxDepth 5 -y
drush cset islandora_breadcrumbs.breadcrumbs includeSelf true -y
```

## Behavior (`IslandoraBreadcrumbBuilder`)

- `applies(RouteMatch)` — returns TRUE for Islandora node canonical routes.
- `build(RouteMatch)` — starting from the current node, repeatedly loads the parent referenced by the first
  populated `referenceFields` field, prepending each ancestor as a breadcrumb link, up to `maxDepth`. Adds
  the current node last only when `includeSelf` is TRUE. Ancestor resolution uses Islandora Core's
  `IslandoraUtils`.

Breadcrumbs are computed at request time, so they always reflect the current membership structure.
