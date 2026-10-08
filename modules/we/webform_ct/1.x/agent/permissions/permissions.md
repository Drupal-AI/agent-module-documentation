<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions (webform_ct)

Defined statically in `webform_ct.permissions.yml`. One permission.

## `webform_ct.administer_webform_confirmation_javascript`

- **Title:** "Administer Webform Confirmation JavaScripts"
- **Description:** "Allows to set and edit custom JavaScripts for Webform confirmation pages (e.g.
  conversion tracking codes)."
- **`restrict access: true`** — Drupal shows the standard "this permission has security
  implications" warning on the permissions page and treats it as a trusted-role grant.

## What it gates

It is the `#access` condition on the `confirmation_custom_javascript` field added to the webform
Confirmation settings form (`webform_ct.module:55`, `:81`). A user without this permission does not
see the field, and — because the element is `#access`-gated — cannot submit a value for it. There is
no separate route/permission for this module; the field is the only surface, and this permission is
its only access control.

## Check from code

```php
\Drupal::currentUser()->hasPermission('webform_ct.administer_webform_confirmation_javascript');
```

Grant it only to roles you intend to trust with the confirmation JavaScript field. It is independent
of Webform's own permissions (`administer webform`, `edit any webform`, etc.), so it can be granted
or withheld separately from general webform administration.
