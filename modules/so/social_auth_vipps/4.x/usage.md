<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds Vipps as a Social Auth provider so visitors can authenticate, log in, or register on the site using their Vipps (Norwegian mobile-pay/identity) account.

---

Built on the Social API / Social Auth framework, the module registers a `VippsAuth` network plugin wrapping a League OAuth2 client for Vipps (`api.vipps.no`). The flow is the standard Authorization Code grant: `user/login/vipps` (`redirectToProvider`) sends the user to Vipps with the OpenID scopes (`openid`, `address`, `email`, `name`, `phoneNumber`), and `/user/login/vipps/callback` receives the code, exchanges it for a token, fetches the resource owner, and hands the profile to Social Auth's `UserAuthenticator` to log in or create the account. An event subscriber turns Vipps `error` responses into a redirect back to the login page, and the resource owner enforces an email-verification guard.

Both routes are `_access: 'TRUE'` — necessarily, since anonymous users must be able to start and finish login — but CSRF is protected: `VippsAuthController` extends Social Auth's `OAuth2ControllerBase`, and `processCallback()` calls `parent::processCallback()` which validates the OAuth2 `state`. This module actually *hardens* the base flow: `redirectToProvider()` also stores the generated state in Drupal state keyed with a timestamp, and `processCallback()` re-validates against that store (with a ~2-minute window) so a valid state cannot be replayed and app-return flows still verify state. Settings (client id/secret) live at `/admin/config/social-api/social-auth/vipps` behind `administer social api authentication`.

Setup: install `social_auth` and this module, create a Vipps merchant/login application, enter the client credentials and redirect URI on the settings form, and place the Social Auth login block or link. Users then log in via the Vipps button.

---

- Let users log in with their Vipps account
- Register new Drupal accounts from Vipps identity
- Associate a Vipps identity with an existing logged-in user
- Request OpenID scopes (email, name, address, phone) from Vipps
- Redirect users to Vipps for authorization
- Handle the OAuth2 callback and token exchange
- Verify the OAuth2 `state` to prevent login CSRF
- Enforce an extra timestamped state check via Drupal state
- Pull email, nickname and avatar into the Drupal account
- Reject unverified-email Vipps profiles via the verification guard
- Show a Vipps login button through the Social Auth block
- Redirect back to login on a Vipps error response
- Configure client id/secret at the Social Auth Vipps settings form
- Support the Vipps app automatic-return login flow
- Restrict provider settings behind `administer social api authentication`
- Add Norwegian mobile identity login to a Drupal site
- Reuse Social Auth's user mapping and account linking
- Provide passwordless sign-in via Vipps
- Extend requested scopes with extra configured scopes
- Log token-exchange failures to the `social_auth_vipps` channel
