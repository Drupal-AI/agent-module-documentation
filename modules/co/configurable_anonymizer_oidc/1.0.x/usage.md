<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Configurable Anonymizer OIDC skips anonymizing users based on OIDC realm.

---

Configurable Anonymizer OIDC extends the **Configurable Anonymizer** module to **skip anonymizing users
based on their OIDC realm** — so when anonymizing user data (e.g. for lower environments / GDPR), users
belonging to a configured OpenID Connect realm can be excluded from anonymization. It depends on Configurable
Anonymizer and the OIDC module, provides its own permissions, in the Custom package.

Use it to control anonymization by OIDC realm. It is a privacy/data-handling feature. Understand the
implication carefully: **excluding users from anonymization means their real data is retained** where other
users' data is scrubbed — so only exclude realms where retaining real data is intended and compliant, and
review the exclusion against your privacy requirements. It has no access-control role beyond its permission.
Configure the OIDC-realm exclusions.

---

- Skip anonymizing by OIDC realm.
- Exclude an OIDC realm from anonymization.
- Extend Configurable Anonymizer.
- Depend on Configurable Anonymizer and OIDC.
- Serve GDPR/lower-environment anonymization.
- Retain real data for excluded realms.
- KNOW exclusion retains real user data.
- Only exclude where retention is intended/compliant.
- Review against privacy requirements.
- Provide its own permissions.
- Have no access-control role beyond permission.
- Configure the realm exclusions.
- Handle anonymization exclusion.
- Exclude realms.
- Configure the exclusions.
- Control anonymization.
- Handle the add-on.
- Skip anonymization.
- Set the exclusions.
- Provide realm-based exclusion.
