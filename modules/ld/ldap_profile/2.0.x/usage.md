<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
LDAP Profile extends LDAP mapping to profile fields for LDAP identified users.

---

LDAP Profile extends the **LDAP** integration to map LDAP attributes into **Profile** fields — for users
authenticated/provisioned via LDAP, it syncs additional directory attributes into their Drupal profile beyond
the basics the LDAP User module handles. It depends on the LDAP User module (ldap_user), in the LDAP package.

Use it to enrich Drupal profiles from LDAP. It is an authentication/directory-integration feature layered on
the LDAP suite. Security handling flows through the LDAP module's connection: ensure the LDAP connection uses
**LDAPS/StartTLS** (encrypted) and that the LDAP **bind credentials** are stored as secrets (the LDAP module's
settings), since directory data and credentials are sensitive. It maps attributes but has no access-control
role of its own. Configure the LDAP-to-profile field mapping.

---

- Map LDAP attributes to Profile fields.
- Enrich profiles from the directory.
- Extend LDAP User mapping.
- Depend on the LDAP User module.
- Sync directory attributes.
- Serve LDAP-identified users.
- Use LDAPS/StartTLS for the connection.
- Store LDAP bind credentials as secrets.
- Treat directory data as sensitive.
- Have no access-control role of its own.
- Configure the field mapping.
- Handle LDAP profiles.
- Sync profile fields.
- Configure the mapping.
- Map attributes.
- Handle the integration.
- Enrich profiles.
- Sync attributes.
- Secure the connection.
- Provide LDAP profile mapping.
