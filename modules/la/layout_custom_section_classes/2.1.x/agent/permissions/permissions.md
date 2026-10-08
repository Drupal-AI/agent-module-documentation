<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Defined in `layout_custom_section_classes.permissions.yml`:

| Permission | Gates |
|---|---|
| `administer layout builder section classes module settings` | access to the global settings form (`/admin/config/content/layout-builder-section-attributes`) — the `layout_custom_section_classes.settings` route requirement |
| `administer layout builder section attributes` | whether a user sees the **section-level** attribute fields (ID, class, class list, style, data-*) in the Configure section form |
| `administer layout builder sections region attributes` | whether a user sees the **region-level** attribute fields in the Configure section form |

The section/region permissions are checked in
`hook_form_layout_builder_configure_section_alter()` before adding their respective fieldsets, so
a user must also have Layout Builder access to reach the form at all.

Grant, e.g.:

```bash
drush role:perm:add editor 'administer layout builder section attributes'
```
