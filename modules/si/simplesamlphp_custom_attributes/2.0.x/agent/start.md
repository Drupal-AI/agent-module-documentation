<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SimpleSAMLphp Custom Attribute Mapping (`simplesamlphp_custom_attributes`) — agent index

Child module of [`simplesamlphp_auth`](https://www.drupal.org/project/simplesamlphp_auth). Adds an
admin UI to map named **SAML attributes → Drupal user fields**. On each SAML login it implements
`hook_simplesamlphp_auth_user_attributes()` to copy the IdP-supplied attribute values onto the mapped
fields of the account. Version **2.0.2**, core `^10 || ^11.3`, requires `drupal/simplesamlphp_auth:^4.1`.

- **Configure route** → `simplesamlphp_custom_attributes.list` (`admin/config/people/simplesamlphp-custom-attributes`).
- **Defines no permission of its own** — every route reuses `administer simplesamlphp authentication` (from `simplesamlphp_auth`).
- No Drush commands, no plugin types, no services. Provides config schema.

Solution docs:
- **Add / edit / delete mappings; the config object and schema; set mappings via drush/PHP** → [configure/mappings.md](configure/mappings.md)
- **How values get written to fields on login (the hook, field-type & cardinality logic)** → [hooks/attribute_mapping.md](hooks/attribute_mapping.md)

Key facts:
- Config object: `simplesamlphp_custom_attributes.mappings`, single key `mappings` — a sequence of
  `{ attribute_name: <SAML attr>, field_name: <user field machine name | 'custom'> }`. Default install: `mappings: {}`.
- Routes: `.list` (table controller), `.add` / `.edit` (`{mapping}`) / `.delete` (`{mapping}`) — all
  `_permission: 'administer simplesamlphp authentication'`.
- Controller `SimplesamlphpCustomAttributesController::ssoMappings`; forms `SimplesamlphpCustomAttributesEditForm`,
  `SimplesamlphpCustomAttributesDeleteForm`; hook in `simplesamlphp_custom_attributes.module`.
- The field select in the add/edit form only offers fields whose storage provider is **not** `user`
  (i.e. added/Field-API fields), plus a `Custom` placeholder — so core user fields (name, mail, roles,
  status) are not selectable there.
- Menu link under `user.admin_index` (People); action link "Add Mapping"; config-translation enabled for the mappings config.
