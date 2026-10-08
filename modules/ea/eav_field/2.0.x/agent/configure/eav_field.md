<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring EAV Field

1. Enable: `drush en eav_field -y` (pulls entity, field, text, options).
2. Create attributes: *Structure > EAV > Attributes* (`/admin/structure/eav/attributes`), **Add attribute**. Grant `administer eav attributes` to the roles that manage them.
3. Per attribute, use the local tabs to configure:
   - **Storage** (`/storage`) — the value field type (string, text, integer, boolean, options) and cardinality.
   - **Field** (`/field`) — value field settings (required, allowed values …).
   - **Widget** (`/widget`) — the edit widget.
   - **Formatter** (`/formatter`) — the display formatter.
4. Optionally set the attribute's **category** (taxonomy term) to scope it; leave empty for a global attribute.
5. Add an **EAV** field to the target bundle (Manage fields). To auto-match category-scoped attributes, give the bundle an entity-reference field pointing at the same taxonomy vocabulary used by attribute categories.
6. Edit values on the host entity form, or via the **Edit EAV** local task at `{entity-canonical}/edit-eav/{field_name}` (requires `update` access to that entity).

Attributes are matched to a host by `loadByHostEntityCategory()`: global attributes plus those whose category (and parent terms) match the host's category reference.