# Configuration

All of this module's behavior is driven by one settings form: a grid of node
fields against roles. Ticking a box hides that field's widget on the add/edit form
for that role.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Navigate to `/admin/config/field_visibility_manager/adminsettings`.

## Read the table

- **Rows** are the fields available on your node bundles — specifically every field
  whose machine name starts with `field_`. The table maintains itself: a field you
  add later shows up here automatically, and a field you delete is dropped from the
  saved settings.
- **Columns** are the roles configured on your site.

## Hide a field for a role

1. Find the row for the field you want to restrict.
2. Tick the checkbox in the column for each role that should **not** see that field
   on the add/edit form.
3. Click **Save**.

From then on, any user in a ticked role loses that field's widget when creating or
editing the relevant node — the input is removed from the form, and they cannot
submit a value for it. A user who holds more than one role is blocked from a field
whenever **any** of their roles is ticked against it.

## What this does and does not do

- **It does** enforce the restriction server-side. Because the module sets the form
  element's `#access` to `FALSE`, Drupal's Form API removes the element from
  processing and submission — a blocked role cannot inject a value by manipulating
  the request.
- **It does not** hide the field's *value* anywhere it is displayed. The rendered
  node, Views, and REST/JSON:API still expose the value to anyone who can view the
  entity. If you also need to hide the value from being read, combine this module
  with a dedicated field display or field-access-control module.

To reverse a restriction, untick the box and save again.
