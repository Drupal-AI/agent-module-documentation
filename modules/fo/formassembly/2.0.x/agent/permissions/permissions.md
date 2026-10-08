# Permissions & entity access

Defined in `formassembly.permissions.yml`:

| Permission | Title | Notes |
|---|---|---|
| `administer formassembly form entities` | Administer FormAssembly Form entities | `restrict access: true`. Entity admin permission; gates the settings form and both OAuth routes. |
| `edit formassembly form entities` | Edit FormAssembly Form entities | `update` op on `fa_form`. |
| `access formassembly form overview` | Access the FormAssembly Form overview page | Gates the collection route `entity.fa_form.collection` (`/formassembly/fa_form`). |
| `view formassembly form entities` | View FormAssembly Form entities | `view` op — required to render a form on its canonical path. |
| `reference formassembly` | Select FormAssembly Forms to embed via Entity Reference fields | Grants edit access to entity-reference fields targeting `fa_form` (via `hook_entity_field_access`). |

## Access handler

`FormAssemblyEntityAccessControlHandler::checkAccess()` maps ops to permissions:
`view` → `view formassembly form entities`, `update` → `edit formassembly form entities`,
`delete` → `delete formassembly form entities`. `checkCreateAccess()` → `add formassembly form entities`.

Operational note: `delete formassembly form entities` and `add formassembly form entities` are **not**
declared in `formassembly.permissions.yml`, so no role can be granted them — direct create/delete of
`fa_form` entities is effectively limited to the super-user. In normal use forms are not created or
deleted by hand: `formassembly.sync` creates entities on sync and archives (disables) forms that
disappear upstream (`FormAssemblyStorage::disableInactive()`).

Entity `admin_permission` is `administer formassembly form entities`.
