<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

One permission (`administration_language_negotiation.permissions.yml`):

| Permission | Machine name | Gates |
|---|---|---|
| Administration language negotiation | `use administration language negotiation` | Whether the negotiation method runs for this user at all, and whether the core "Administration pages language" (`preferred_admin_langcode`) field is shown on their user edit form. |

- The negotiation method's `getLangcode()` returns early (no admin language) unless the
  current user `hasPermission('use administration language negotiation')`.
- Description (verbatim): "Gives the option to select a preferred administration language
  even if not an administrator" — i.e. it lets non-admin roles choose an admin language.
- The settings **form** itself is protected by the core `administer languages` permission
  (route requirement), not this one.

Grant it:

```bash
drush role:perm:add editor 'use administration language negotiation'
```
