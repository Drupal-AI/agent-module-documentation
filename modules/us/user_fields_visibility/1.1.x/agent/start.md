<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# User Fields Visibility — agent index

Lets **users choose which of their profile fields are visible to others**. Depends on `field_permissions` (hard
dep). Provides permissions. Version **1.1.0-alpha4**. Core `^9||^10||^11`.

**Correctly enforced**: a Field Permissions plugin (`hasFieldAccess`) at the **field-access layer** — respected
by rendered profiles, **JSON:API, REST and Views** (hidden values don't leak via the API). Admins/owner always
see; others only owner-marked-visible fields (default visible). Settings form gated. Access/privacy.
