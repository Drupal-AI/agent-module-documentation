# PrevNext permissions

Defined in `prevnext.permissions.yml` plus a dynamic callback
(`Drupal\prevnext\PrevNextPermissions::permissions`).

| Permission | Type | Gates |
|---|---|---|
| `administer prevnext` | static, `restrict access: TRUE` | The settings form `/admin/config/user-interface/prevnext`. |
| `view prevnext links` | static | Global: see PrevNext links on **any** enabled entity type. |
| `view {entity_type} prevnext links` | dynamic (one per type) | See the links on that specific entity type only. |

The dynamic permissions are generated for **every** fieldable entity type
(`FieldableEntityInterface`) that has a `canonical` link template — e.g. `view node prevnext links`,
`view taxonomy_term prevnext links`. Access in both the service (`buildEntityLinks`) and the block
(`blockAccess`) passes if the user has the global `view prevnext links` **or** the matching
per-type permission. Grant the global one for a simple setup, or per-type permissions to expose
navigation on some entity types but not others.
