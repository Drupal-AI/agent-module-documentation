<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

From `registration_inline_entity_form.permissions.yml` (plus a permission provider):

| Permission | Allows |
|---|---|
| `edit registration settings` | edit **all** registration settings for new and existing host entities, regardless of the host's registration type |

This lets an editor manage the inline registration settings embedded on the host form without needing
the broader `administer registration` permission. The permission provider
(`RegistrationInlineEntityForm\RegistrationPermissionProvider::buildPermissions`) may expose related
per-type variants.
