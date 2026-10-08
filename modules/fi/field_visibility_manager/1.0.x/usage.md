<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Field Visibility Manager provides an admin settings table that hides specific node fields on the content add/edit form for selected roles.

At `/admin/config/field_visibility_manager/adminsettings` (`administer site configuration`) the form lists node-bundle fields (machine names starting with `field_`) as rows and roles as columns; ticking a role for a field records that in `field_visibility_manager.adminsettings:permissions`. A `hook_form_alter` then loops the saved rows and, for any field whose row has one of the current user's roles set to 1, sets `$form[$fieldname]['#access'] = FALSE`, removing the widget from the entity form.

Scope and security: this hides field **widgets on entity forms only**. Setting `#access = FALSE` is honored server-side by Drupal's Form API (the element is dropped from processing and submission, so a targeted role cannot inject a value), which makes it a genuine edit-time restriction rather than pure CSS hiding. However, the module does **not** implement `hook_entity_field_access`, so it does not restrict *viewing* or display of the field value anywhere — the rendered node, REST/JSON:API, and Views still expose it. Do not treat it as field read-access control. The admin route is gated by `administer site configuration`; only node entity forms are affected.
---
Hide chosen node fields from the add/edit form for selected roles (form-widget access only, not display).
---
- Hide a field's widget on the node add form for a role
- Hide a field's widget on the node edit form for a role
- Restrict which roles can edit specific node fields
- Configure per-field, per-role visibility in one table
- Prevent a role from submitting a value for a hidden field
- Keep sensitive editorial fields out of certain roles' forms
- Manage visibility for all node bundles from one screen
- Automatically include newly added fields in the settings table
- Drop removed fields from the saved configuration
- Apply to any field whose machine name starts with `field_`
- Combine multiple roles' rules for a multi-role user
- Store the rules in `field_visibility_manager.adminsettings`
- Gate the settings form behind `administer site configuration`
- Use alongside proper display/access modules for view control
- Audit which roles are blocked from which node fields
