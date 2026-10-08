<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Save a user's ORCID to a field, authenticated via the ORCID API.

---

Link an ORCID confidently saves a user's ORCID iD to a configured field, authenticated by the ORCID API — so instead of a user typing an ORCID that could be wrong/spoofed, they authenticate with ORCID (OAuth) and the verified iD is stored, ensuring the ORCID genuinely belongs to them.

The ORCID API client credentials are stored via a Key entity (`key` dependency, env-backed). Depends on core `user`, `field`, and `key`; supports Drupal 10 and 11.

---

- Save a verified ORCID iD.
- Authenticate via the ORCID API.
- Prevent spoofed ORCIDs.
- Store to a configured field.
- Use ORCID OAuth.
- Store credentials via a Key entity.
- Depend on core `user`, `field`, `key`.
- Support Drupal 10 and 11.
- Configure the field/connection.
- Aid academic profiles.
- Handle ORCID linking.
- Verify identity
- Support Drupal.
- Support Drupal.
- Support Drupal.
