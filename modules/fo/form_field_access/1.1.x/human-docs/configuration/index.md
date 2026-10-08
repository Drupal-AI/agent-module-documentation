# Configuration

Form Field Access is configured from a single admin page where you choose an
entity type and bundle, then decide which roles are denied access to which fields
on the edit form.

## Open the configuration page

1. Log in as a user with the module's administration permission (an administrator
   by default).
2. Go to **`/admin/people/form-field-access`** (under **People**).

## Set per‑role field access

1. **Select the entity type and bundle** whose form you want to control — for
   example, the *Article* content type, or a specific taxonomy vocabulary or user
   role, depending on your entities.
2. You are shown a **field / role matrix** listing the fields on that bundle down
   one axis and your site's roles across the other.
3. Use the matrix to **disallow** fields for specific roles. A user in a
   disallowed role will not see that field on the add/edit form. Leave a field
   allowed for a role to keep core's normal behaviour.
4. Save the configuration.

The rule takes effect immediately: when a user in a restricted role opens the
add/edit form for that bundle, the denied field is not available to them.

## Understand exactly what this restricts

This is the most important part to get right:

- It controls the **edit form** — whether a role can see and edit a field while
  adding or editing an entity.
- It does **not** control field **view** access. The field's value is still
  rendered on the page, and still exposed via JSON:API, REST, and Views, for
  anyone who can access those. Hiding a field on the form does not hide its value
  elsewhere.
- If you need to restrict who can **read** a field's value, use a field‑view
  access mechanism such as
  [Field Permissions](https://www.drupal.org/project/field_permissions). Form
  Field Access can be used together with it.

In short: use Form Field Access to control **editing**, and use field‑view access
to control **reading**. It layers on top of core's own field access, so core
restrictions still apply as well.
