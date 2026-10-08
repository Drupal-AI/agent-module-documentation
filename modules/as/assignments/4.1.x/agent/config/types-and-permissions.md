<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bundles (`assignment_type`), permissions, and config schema

Source: `src/Entity/AssignmentType.php`, `src/Entity/AssignmentTypeInterface.php`,
`src/AssignmentTypeListBuilder.php`, `src/AssignmentTypeHtmlRouteProvider.php`,
`src/Form/AssignmentType*Form.php`, `config/schema/assignment_type.schema.yml`,
`assignments.permissions.yml`, `assignments.links.*.yml`.

## The `assignment_type` config entity (bundles)

`@ConfigEntityType(id = "assignment_type")` — extends `ConfigEntityBundleBase`, is the
`bundle_of = "assignment"`.

- `config_prefix = "assignment_type"` → config objects named `assignments.assignment_type.<id>`.
- `admin_permission = "administer site configuration"` — so creating/editing/deleting a bundle
  requires that core permission (NOT `administer assignment entities`).
- `config_export = { "id", "label" }` — only id + label are stored.
- entity_keys: `id`, `label`, `uuid`.
- links / routes (via `AssignmentTypeHtmlRouteProvider`, an unmodified `AdminHtmlRouteProvider`
  subclass): collection `/admin/structure/assignment_type`, add `/add`, canonical
  `/{assignment_type}`, edit `/{assignment_type}/edit`, delete `/{assignment_type}/delete`.
- `AssignmentTypeForm` provides a Label textfield + machine-name (`exists` →
  `AssignmentType::load`), redirects to the collection on save. `AssignmentTypeDeleteForm`
  confirm-deletes and messages "content @type: deleted @label."
- `AssignmentTypeListBuilder` lists bundles with `Assignment type` (label) + `Machine name` (id).
- `AssignmentTypeInterface` adds no methods.

Create bundles before adding assignments — the content entity's add-form route is
`/admin/content/assignment/add/{assignment_type}`.

## Config schema (`config/schema/assignment_type.schema.yml`)

```yaml
assignments.assignment_type.*:
  type: config_entity
  label: 'Assignment type config'
  mapping:
    id: { type: string, label: 'ID' }
    label: { type: label, label: 'Label' }
    uuid: { type: string }
```

There is **no** `config/install/*` (no default bundles shipped) and no module settings object.

## Permissions (`assignments.permissions.yml`)

| Permission | Guards |
|-----------|--------|
| `add assignment entities` | create access (`checkCreateAccess`) |
| `edit assignment entities` | `update` operation |
| `delete assignment entities` | `delete` operation |
| `view published assignment entities` | `view` (published) |
| `view unpublished assignment entities` | `view` (unpublished — see quirk below) |
| `administer assignment entities` | admin_permission of the entity; **`restrict access: true`** |

Grant `administer assignment entities` and `view unpublished assignment entities` only to trusted
roles. Note the `isPublished()`-always-`TRUE` quirk (see
[../entities/assignment.md](../entities/assignment.md)) means the "unpublished" permission has no
practical effect on normally-created records.

Bundle management (`assignment_type` CRUD) is gated separately by the core
`administer site configuration` permission.

## Menu / task / action links (`assignments.links.*.yml`)

- Menu: `Assignment list` under **Content** (`system.admin_content`), `Assignment type` under
  **Structure** (`system.admin_structure`).
- Local tasks: View / Edit / Delete tabs on an assignment's canonical route.
- Local actions: "Add Assignment" on the assignment collection, "Add Assignment type" on the
  bundle collection.
