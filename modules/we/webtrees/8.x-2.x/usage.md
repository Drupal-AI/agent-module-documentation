<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webtrees provides single sign-on support for Webtrees.

---

Webtrees provides **single sign-on (SSO) support between Drupal and Webtrees** — the open-source genealogy
platform — so users authenticated in Drupal can access a linked Webtrees installation without a separate login,
with `webtrees_admin_views`/`webtrees_views` submodules. It depends on core System and User, in the Webtrees
package.

Use it to bridge Drupal auth to Webtrees. It is an authentication/integration feature and it is **security-
sensitive**: SSO ties two systems' identities together, so review how the trust is established — the **shared
secret/token** used to assert the Drupal identity to Webtrees must be kept secret (env/Key), transmitted over
HTTPS, and validated by Webtrees, and account mapping should be unambiguous. Verify the SSO mechanism in your
setup before relying on it. It layers on core auth; configure the SSO carefully.

---

- Provide Drupal↔Webtrees SSO.
- Bridge auth to Webtrees genealogy.
- Avoid a separate Webtrees login.
- Depend on core System and User.
- Provide views submodules.
- Serve the Webtrees integration.
- BE security-sensitive (ties identities together).
- Keep the SSO shared secret/token secret (env/Key, HTTPS).
- Ensure unambiguous account mapping + validation.
- Review the SSO mechanism before relying on it.
- Layer on core auth.
- Configure the SSO carefully.
- Handle Webtrees SSO.
- Bridge auth.
- Configure the SSO.
- Link identities.
- Handle the integration.
- Enable SSO.
- Secure the token.
- Provide Webtrees SSO.
