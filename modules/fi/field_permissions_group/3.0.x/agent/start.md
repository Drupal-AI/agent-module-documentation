<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field Permissions Group — agent index

Extends **Field Permissions** with a **Group-aware** field-permission type — create/edit/view field
access based on **group membership + group permission**. Depends on `field_permissions`, `group`.
Version **3.0.3**. Core `^10||^11`.

**Access-control feature, fail-closed:** `CustomGroupAccess` grants field access only when the account
holds the specific group permission (no membership/permission → no access). Verify the group-permission
mapping matches intent; enforced wherever entity/field access is checked.
