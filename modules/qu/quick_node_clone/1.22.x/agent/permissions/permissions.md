# Quick Node Clone permissions

Static (`quick_node_clone.permissions.yml`):
- `Administer Quick Node Clone Settings` — access the settings/exclusion forms.

Dynamic, per content type (`QuickNodeClonePermissions::cloneTypePermissions`):
- `clone <type_id> content` — clone any node of that content type.
- `clone own <type_id> content` — clone only nodes the user authored, of that type.

Grant the per-type permissions to the roles that should see the Clone action on each
content type.
