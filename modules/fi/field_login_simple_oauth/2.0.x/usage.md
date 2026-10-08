<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
A Simple OAuth password grant that authenticates by a login field.

---

Field Login & Simple OAuth Password Grant implements a password grant for the Field Login module and Simple OAuth — so an OAuth2 password-grant token can be obtained using a configured login field (e.g. email or phone) as the 'username' instead of the account name.

Security: the grant still verifies the password — its `UserRepository::getUserEntityByUserCredentials()` loads the account by the field value and then calls Drupal's `userAuth->authenticateAccount($account, $password)`, so authentication is genuine (no bypass). Depends on `simple_oauth` (>=6.x) and `field_login` (>=3.x); supports Drupal 10.3+ and 11.

---

- Add a field-based OAuth password grant.
- Authenticate by a login field.
- Use email/phone as the username.
- Issue OAuth2 tokens.
- Verify the password (authenticateAccount).
- Not bypass authentication.
- Build on Field Login + Simple OAuth.
- Depend on `simple_oauth` and `field_login`.
- Support Drupal 10.3+ and 11.
- Configure the login field.
- Aid decoupled auth.
- Handle OAuth login
- Support Drupal.
- Support Drupal.
- Support Drupal.
