<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the permission-aware reference widget

1. On the entity-reference field settings, set the reference handler to **"Create referenced entities if they don't already exist"** (autocreate).
2. On the bundle's **Manage form display**, choose the widget **"Autocomplete (with new entity permission)"** for the field.
3. At `admin/people/permissions`, grant **"Create new autocomplete referenced entity"** to the roles that should be allowed to create new target entities inline.

Behaviour: users WITH the permission see the normal autocreate autocomplete; users WITHOUT it get an autocomplete that unsets `#autocreate`, so they can only reference entities that already exist. The permission is declared `restrict access: TRUE`.
