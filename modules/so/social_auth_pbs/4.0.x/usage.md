<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
A Social Auth integration that adds "Log in with PBS" to a Drupal site, including PBS Account's federated Apple, Facebook, Google and account-registration variants, all over OAuth2 authorization-code flow.

---

Built on the `social_auth`/`social_api` framework and the `openpublicmedia/oauth2-pbs` League provider, the module registers a set of Network plugins — `social_auth_pbs` (base PBS) plus `_apple`, `_facebook`, `_google` and `_register` variants — that all share one redirect route (`user/login/pbs`) and one callback route (`user/login/pbs/callback`). A single controller (`PbsAuthController`) handles every variant; the specific sub-network is carried through the OAuth flow in the Social Auth data handler (session), keyed by a `network` query parameter, so the callback can re-resolve which provider was used. The register variant additionally routes the user through PBS's `/oauth2/register/?next=...` account-creation page before the standard authorization step, and forces an `activation=true` parameter so PBS runs its VPPA activation check.

Both routes are `_access: 'TRUE'` by necessity — anonymous users must be able to start login, and authenticated users can associate a new provider — which is the standard Social Auth posture; the security-relevant OAuth `state` (CSRF) handling, token exchange over TLS and session data-handler logic live in the inherited `OAuth2ControllerBase`/`OAuth2Manager` from the `social_auth` base module, not re-implemented here. Configure the client ID/secret and scopes at `/admin/config/social-api/social-auth/pbs` (route `social_auth_pbs.settings_form`). User info (name, id, email, first/last name) is read from the PBS resource owner and handed to Social Auth, which maps or creates the Drupal account per the site's Social Auth settings.

---
- Add a "Log in with PBS" button to the site
- Let visitors register/authenticate with their PBS Account
- Offer PBS-federated Apple sign-in
- Offer PBS-federated Facebook sign-in
- Offer PBS-federated Google sign-in
- Send new users through PBS's account-registration flow (register variant)
- Force a PBS VPPA activation check during authorization (`activation=true`)
- Let an authenticated user link a PBS provider to their account
- Configure client ID and secret at the PBS settings form
- Set the OAuth scopes requested from PBS
- Map PBS profile fields (name, email) onto Drupal accounts via Social Auth
- Auto-create Drupal accounts on first PBS login (per Social Auth config)
- Place the Social Auth login block/links to expose the PBS button
- Support multiple PBS sub-networks through one shared callback
- Pull the PBS resource owner's first/last name into the profile
- Integrate PBS Passport / linked-service access via VPPA activation
- Log authentication failures to the `social_auth_pbs` logger channel
