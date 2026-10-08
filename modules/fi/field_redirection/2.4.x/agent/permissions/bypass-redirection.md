<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permission: `bypass redirection`

The module defines a single permission in `field_redirection.permissions.yml`:

| Permission | Machine name | Effect |
|---|---|---|
| Bypass redirection | `bypass redirection` | The user is **not** redirected; they see the source entity page instead. |

## What it does

In `FieldRedirectionResultBuilder::shouldDeny()` the very first check is
`if ($account->hasPermission('bypass redirection')) { return TRUE; }` — denying the redirect.
Then in the formatter, when the current user has the permission and the field is not empty, a
warning message is shown:

> "This page is set to redirect to another URL, but you have permission to see this page and
> will not be automatically redirected."

with a link to the destination. This lets editors/admins actually reach and edit an entity
whose Full-content view would otherwise bounce them away.

## Grant it

```bash
drush role:perm:add editor 'bypass redirection'
```

or in PHP:

```php
user_role_grant_permissions('editor', ['bypass redirection']);
```

There are no other permissions and no configure route.
