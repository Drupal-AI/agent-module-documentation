<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring JSON:API Entity Operations

1. Enable: `drush en jsonapi_entity_operations -y` (requires core `jsonapi`).
2. Grant **View JSON:API entity operation link** (`view jsonapi_entity_operations`) to the roles that should see the link. Grant **Administer …** (`administer jsonapi_entity_operations configuration`, restricted) to site admins.
3. Go to *Configuration > Web services > JSON:API > Entity Operation Settings* (`/admin/config/services/jsonapi/entity_operations/settings`) and select which **entity types** show the link. Default install config lists `node`.
4. On those entities' admin listings, the operations dropbutton now includes **See JSON:API resource** (opens `jsonapi.{type}--{bundle}.individual` in a new tab).

**Important:** this only adds a navigation link. It does not create JSON:API write routes and does not alter who may read/write the resource — that is still enforced by core JSON:API and entity access. To actually allow JSON:API writes you configure core JSON:API (read-only vs read-write) and entity/permission access separately.