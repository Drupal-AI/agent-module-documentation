<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Okta User Sync

## Where things live
Admin area: `/admin/config/people/okta_user_sync/overview` (form `MoOktaOverview`).
All tabs require the `administer site configuration` permission.

Config object `okta_user_sync.settings` holds:
- `okta_user_sync_base_url` — your Okta org URL.
- `okta_user_sync_upn` — the user principal name used for test lookups.
- `okta_user_sync_bearer_token` — the Okta API token (sent as `SSWS <token>`).

## Connecting to Okta
`MoOktaHelper::getUserFromOkta($token, $url)` issues a Guzzle GET with header
`Authorization: SSWS <token>`. Test URLs are built by `creatUrlForTesting()` as
`<base>/api/v1/users/<upn>`. `fetchAttributes()` stores the flattened attribute
list in `mo_okta_attr_list_from_server` for the mapping UI.

## Provisioning
- Drupal→Okta tab (`MoDrupalToOkta`) copies the bearer token into
  `mo_provider_specific_provisioning_api_token` for the user_provisioning layer.
- Okta→Drupal tab (`MoOktaToDrupal`) pulls users in.
- Mapping tab (`MoMappingTab`) maps user fields to Okta attributes.
- Real-time sync runs from Drupal user CRUD hooks; cron/manual options exist per help.

## Security guidance
The API token is stored in plaintext config and re-rendered into the form
(`#value` in `MoOktaOverview`). It is not a Key entity, so treat `administer site
configuration` as credential access and exclude this config from public exports.
Outbound calls use default TLS verification — do not disable it.
