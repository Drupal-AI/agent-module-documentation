<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Defined in `hide_revision_field.permissions.yml`. Grant/revoke on
`/admin/people/permissions` or with Drush.

| Permission machine name | Label | Gates |
|---|---|---|
| `access revision field` | Control Revision Messages | When a bundle's widget has `permission_based = true`, the revision log field is shown **only** to users holding this permission (and hidden from everyone else, regardless of `show`). |
| `administer revision field personalization` | Administer own revision field display | When a bundle's widget has `allow_user_settings = true`, users with this permission get a "Revision Field Settings" section on their user profile form (`/user/{uid}/edit`) to override, per entity type + bundle, whether the revision log field is shown to them. Their saved override wins over the bundle default. |

## Grant via Drush

```bash
drush role:perm:add content_editor 'access revision field'
drush role:perm:add content_editor 'administer revision field personalization'
```

Check which roles have a permission:

```bash
drush php:eval '
  foreach (\Drupal::entityTypeManager()->getStorage("user_role")->loadMultiple() as $r) {
    if ($r->hasPermission("access revision field")) { print $r->id() . "\n"; }
  }
'
```

## Per-user personalization storage

The module adds a `revision_log_settings` base field to the **user** entity (a serialized
`string_long`). It stores a nested `[entity_type][bundle] => bool` map of the user's
show/hide choices, written from the profile form and read back by the widget.
