<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
SimpleSAMLphp Custom Attribute Mapping is a child module of simpleSAMLphp Authentication that maps named SAML attributes from the identity provider onto Drupal user fields at login.

---

SimpleSAMLphp Custom Attribute Mapping adds an admin UI under People where you pair a SAML attribute name (a friendly name like `givenName`/`sn`, or an OID such as `urn:oid:...`) with a Drupal user field. The pairs are stored in the `simplesamlphp_custom_attributes.mappings` config object. On each federated login it implements `hook_simplesamlphp_auth_user_attributes()` from simpleSAMLphp Authentication, reads the mapped attributes out of the IdP assertion, and writes their values to the matching user fields (with basic handling for entity-reference fields and multi-value cardinality) so profile data stays sourced from the IdP. It requires simpleSAMLphp Authentication and reuses that module's "administer simplesamlphp authentication" permission.

---

- Map extra SAML attributes to Drupal user fields.
- Sync a department attribute to a profile field.
- Populate a job-title field from the IdP.
- Fill a phone-number field from SAML on login.
- Keep user profile data authoritative in the identity provider.
- Provision profile fields on first federated login.
- Refresh mapped fields on every login.
- Map an organisation or team attribute to a field.
- Map a manager or location attribute.
- Copy a full-name attribute (OID `urn:oid:2.16.840.1.113730.3.1.241`) into a name field.
- Reference an entity by id supplied as a numeric SAML attribute.
- Append IdP values to a multi-value entity-reference field.
- Map custom IdP claims to added user fields.
- Add mapping rows through an admin UI, no code.
- Edit or delete an existing attribute-to-field mapping.
- Note an attribute with no target using the "Custom" placeholder.
- Manage mappings via drush config:set or the config API.
- Extend simpleSAMLphp Authentication with richer attribute handling.
- Reduce manual profile data entry for SSO users.
- Translate mapping labels through config translation.
