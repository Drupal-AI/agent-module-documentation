<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Amazon Cognito delegates Drupal user sign-in, registration and password management to an Amazon Cognito user pool, mapping Cognito identities to Drupal accounts via External Authentication.

---

Amazon Cognito replaces Drupal's native account flows with Amazon Cognito user-pool flows. Once
enabled, registration, login, password reset, email change and account block/enable all proxy to
Cognito through the AWS SDK (`aws/aws-sdk-php`), and local Drupal accounts are created and linked
through the External Authentication (`externalauth`) module. It is not an OAuth/OIDC redirect SSO
client — it uses Cognito's server-side `ADMIN_NO_SRP_AUTH` admin flow with the user's email and
password, and email is the unique identifier (set when the user pool is created, and immutable).

The AWS connection (region, IAM key/secret, user pool ID, app client ID) is configured in
`settings.php` as `$settings['cognito']`, not in an admin form. The one admin page,
`/admin/config/people/cognito/settings` (permission "Administer Cognito"), only customises the UI
message strings and two behaviour toggles (`click_to_confirm`, `auto_confirm`). The module verifies
each Cognito ID token's signature against the pool's JWKS (RS256) after authenticating, stores the
Access/Id/Refresh tokens server-side in `user.data`, and can expose the current user's tokens over a
REST endpoint so a front-end can call other AWS resources. It also ships an HTTP JSON login endpoint,
a REST registration resource, confirm/verify-email callbacks, and a `cognito:diff-users` Drush
command that reconciles a Cognito user export against Drupal users.

---

- Delegate Drupal login/registration/password reset to an Amazon Cognito user pool.
- Authenticate with email + password via the `ADMIN_NO_SRP_AUTH` admin flow.
- Map Cognito identities to Drupal accounts through External Authentication.
- Verify Cognito ID-token signatures against the pool JWKS (RS256).
- Store Access/Id/Refresh tokens server-side and auto-refresh expired ones.
- Expose the current user's Cognito tokens via `GET /cognito/auth-token` (REST).
- Register users over REST at `POST /cognito/user/register` (anonymous only).
- Log in over HTTP JSON at `POST /cognito/user/login` with core flood control.
- Override the core login, register, profile, password-reset and admin-create forms.
- Support inline-code, click-to-confirm (Lambda) and auto-confirm (Lambda) registration.
- Handle the `NEW_PASSWORD_REQUIRED` challenge after admin-created accounts.
- Mirror Drupal block/unblock to Cognito `adminDisableUser`/`adminEnableUser`.
- Configure the AWS connection in `settings.php`, keeping IAM credentials as env secrets.
- Customise UI messages at `/admin/config/people/cognito/settings`.
- Reconcile Cognito vs Drupal users with `drush cognito:diff-users`.
- Extend registration attributes via the `CognitoEvents::REGISTER` event.
- Recommend the OpenID Connect module + a hosted pool domain for federated IdPs (Facebook/Google/SAML).
