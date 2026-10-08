# Configuration

Using Easy Entity Base Field is a two‑part flow: first you tell it **which entity
types** may have base fields managed through the UI, then you use the generated
**Manage Base Fields** tab on each of those entity types to add the fields.

## 1. Enable the entity types you want to manage

1. Log in as a user with the **Administer easy entity field** permission (restricted
   — grant only to trusted administrators).
2. Go to `/admin/config/development/easy-entity-field`.
3. **Select which entity types** should get base‑field management (Node, User,
   Custom block, and so on). Optionally set the **base route** — where the "Manage
   Base Fields" local task tab should attach on each entity type's UI.
4. Save.

Behind the scenes, the module now generates a set of Field‑UI‑style routes for each
enabled entity type (list, add, storage settings, edit, delete).

## 2. Add base fields

1. Open the entity type you enabled and find its **Manage Base Fields** tab.
2. **Add a field.** Reference‑style base fields are supported out of the box —
   *Entity reference*, *Entity reference revisions*, and *Dynamic entity reference*.
3. Configure the field and its **storage settings**, then save. The module applies
   the new field definition to the entity's schema automatically.

You can return to the tab any time to **edit**, adjust **storage**, or **delete** a
managed field. Deleting cleans up the field's schema.

Remember the limits: **no multi‑value fields** (use core's Field module for those),
and some field types (Map, URI, File URI, Password) store data but need a custom form
element in the entity's add/edit form to capture input.

## 3. Exporting fields for deployment

Each managed field can be exported as configuration named
`easy_entity_field.field.<entity_type>.<field_name>.yml`. Place that file in a custom
module to have the field created automatically when the module is installed — handy
for moving a field between environments as part of a deployment.

## Permissions

- **Administer easy entity field** (restricted) — controls the global settings form
  where you enable entity types.
- **Administer `<entity type>` base fields** (restricted, one per fieldable entity
  type) — controls who may add/edit/delete base fields *on that specific entity
  type*.

Grant these only to trusted administrators: creating or altering a base field is a
schema change, not a routine content edit.
