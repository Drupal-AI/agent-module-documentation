# entity_clone_extras — agent start

Submodule of **entity_clone**. Adds **bundle-level** clone permissions for Node (and Media)
and hides the Clone operation on bundles the user may not clone (via
`hook_entity_operation_alter()`). Requires `entity_clone` + `node`. No config UI.

- Bundle-level clone permissions → [permissions/permissions.md](permissions/permissions.md)
