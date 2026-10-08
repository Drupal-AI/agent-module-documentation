<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration — settings, profiles & OAuth2 connect

## Install
```
composer require drupal/assignments_hootsuite
drush en assignments_hootsuite -y
```
Pulls in `assignments` and `oauth2_client`. Grant `administer hootsuite api settings` (`restrict access: TRUE`) only to trusted operators — it gates all three routes.

## Step 1 — client + endpoint settings
Route `assignments_hootsuite.settings` → `admin/config/services/assignments_hootsuite` (`Form\Settings`, form id `assignments_hootsuite_settings`). Editable config: `assignments_hootsuite.settings`. Fields (all `#required`, saved verbatim in `submitForm()`):

- `client_id`, `client_secret` — Hootsuite app credentials (register at https://developer.hootsuite.com/docs).
- `url_auth_endpoint` — OAuth2 authorize endpoint.
- `url_token_endpoint` — OAuth2 token endpoint.
- `url_post_message_endpoint` — Hootsuite messages API.
- `url_post_media_endpoint` — Hootsuite media API.
- `url_social_profiles_endpoint` — Hootsuite social-profiles API.
- `url_delete_message_endpoint` — declared on the form but the post manager deletes via `url_post_message_endpoint . '/' . post_id`.

There is **no `config/schema/`** and **no `config/install/`** defaults — every endpoint must be entered by hand. The module ships `config/optional/field.storage.*` field-storage definitions for the `field_hs_*` fields and the node `field_hs_assignment` reference.

## Step 2 — connect (OAuth2)
Once `client_id` is set, the form shows a "click here" link built from `HootsuiteAPIClient::createAuthUrl()` (see [../api/client.md](../api/client.md)): `response_type=code`, `client_id`, `scope=offline`, and a `redirect_uri` of `<scheme>://<host>/assignments_hootsuite/callback`. The operator authorizes at Hootsuite and is redirected back to route `assignments_hootsuite.callback` (`Controller\Callback::callbackUrl`, GET only), which reads `code` and calls `HootsuiteAPIClient::getAccessTokenByAuthCode($code)`. On success the access/refresh tokens are written to Drupal **state** (`hootsuite_access_token`, `hootsuite_refresh_token`) and the user is redirected back to the settings form with an "Access tokens saved" message.

`assignments_hootsuite_update_10000` (in `.install`) is a one-time migration that moved these tokens out of the legacy `assignments_hootsuite.tokens` config object into state and deleted that config. (Note: `Form\Settings::buildForm()` still reads a now-unused `assignments_hootsuite.tokens` object to decide whether to warn that tokens are unset.)

## Step 3 — select social profiles
Route `assignments_hootsuite.profiles` → `.../assignments_hootsuite/profiles` (`Form\Profiles`, form id `assignments_hootsuite_profiles`). `buildForm()` calls `HootsuiteAPIClient::connect('get', url_social_profiles_endpoint)` and renders a checkbox per returned profile (`social_profile_<id>`), disabled if a matching bundle already exists (`checkExistingAssignmentType()`).

On submit, for each checked profile not yet materialized, `Profiles`:
1. Creates an `assignment` bundle `AssignmentType` with id `social_profile_<id>`.
2. Calls `addBaseFieldsSocialProfile()` to create the bundle's `field_hs_*` `FieldConfig` (image, post, date, post_id, profile_id, profile_name). `field_hs_profile_id`/`field_hs_profile_name` get default values from the profile.
3. Stores `social_profile_<id> => 1` in `assignments_hootsuite.settings`.

After this, editors attach these assignments to nodes through the `field_hs_assignment` entity-reference field; the hooks then drive posting (see [../api/post-manager.md](../api/post-manager.md)).

Task tabs (`links.task.yml`): "Configure" + "Social profiles" under the settings base route; menu link (`links.menu.yml`) under `system.admin_config_services`.
