# Entity Clone permissions

Defined in `entity_clone.permissions.yml` + dynamic callback
`Drupal\entity_clone\EntityClonePermissions::permissions`.

| Permission | Gates |
|---|---|
| `administer entity clone` | The two settings pages (`entity_clone.settings`, `.cloneable_entities`). |
| `clone {entity_type} entity` | One generated per cloneable entity type (e.g. `clone node entity`, `clone taxonomy_term entity`) — access to that type's clone form/operation. |

Access to a clone form is checked in `entity_clone.module`
(`entity_clone_entity_access` / the clone route access) against the matching
`clone {entity_type} entity` permission, so you can grant cloning of one type without others.

For **bundle-level** control (e.g. allow cloning only `article` nodes), enable the
**entity_clone_extras** submodule, which adds `clone {bundle} {entity_type}` style permissions
for node (and media).
