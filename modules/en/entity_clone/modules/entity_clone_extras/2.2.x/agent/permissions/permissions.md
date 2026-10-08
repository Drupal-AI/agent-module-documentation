# Entity Clone Extras permissions

Provided entirely by the dynamic callback
`Drupal\entity_clone_extras\EntityCloneExtrasPermissions::permissions`
(`entity_clone_extras.permissions.yml` has only `permission_callbacks`).

- Generates one permission **per bundle** of the supported entity types (Node, and Media when
  the Media module is enabled) — e.g. `clone article node`, `clone page node`,
  `clone image media`.
- `entity_clone_extras_entity_operation_alter()` removes the Clone operation from an entity in
  listings when the current user lacks the matching `clone {entity_type} entity` /
  bundle permission, so users only see Clone for content types they may duplicate.

Assign these on **People → Permissions** (`/admin/people/permissions`). Use together with the
base module's per-type `clone {entity_type} entity` permissions for non-node/media entities.
