<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Social Auth PBS — configuration

## Install
`composer require drupal/social_auth_pbs` pulls `social_auth`, `social_api` and `openpublicmedia/oauth2-pbs`. Enable, then configure Social Auth generally (login block, account handling) if not already.

## Register an app with PBS
Obtain a client ID and secret from PBS for your OAuth2 application and set the redirect/callback URL to `https://<site>/user/login/pbs/callback`.

## Configure the module
Go to **Configuration → Social API → Social Auth → PBS** (`/admin/config/social-api/social-auth/pbs`, route `social_auth_pbs.settings_form`) and enter the client ID, secret and scopes.

## Variants
Each Network plugin is a separate provider sharing the same routes:
- `social_auth_pbs` (base, `short_name` = pbs) → League provider `\OpenPublicMedia\OAuth2\Client\Provider\Pbs`
- `social_auth_pbs_apple` / `_facebook` / `_google` → the matching League providers
- `social_auth_pbs_register` → PBS registration flow (redirects through `/oauth2/register/?next=...` then the normal authorize URL)

The variant is chosen by the `network` query parameter on the redirect route (default `pbs`) and stored in the data handler under session prefix `social_auth_pbs` so the shared callback can re-instantiate the right network.

## Flow notes
- Authorization URL always adds `activation=true` (PBS VPPA check) and the configured scopes.
- User identity comes from `PbsAuthManager::getUserInfo()` → Social Auth `SocialAuthUser` (name, id, email, first/last name).
- Failures are logged to the `social_auth_pbs` channel; the callback redirects to `user.login` if the sub-network cannot be resolved from the session.
