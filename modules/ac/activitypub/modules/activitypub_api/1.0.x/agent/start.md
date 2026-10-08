<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ActivityPub API (activitypub_api) — agent index

Helper submodule of **activitypub**. Provides the OAuth2 + REST foundation for client APIs against a
Drupal ActivityPub server. No client endpoints of its own — the Mastodon API submodule builds on it.

## Dependencies
`activitypub`, core `rest`, `simple_oauth`.

## What it provides
- **REST base**: `src/Plugin/rest/resource/ActivityPubApiRestBase.php` (extends `ResourceBase`) — adds
  the route requirement `_user_authenticated_and_has_actor_check: 'TRUE'` (access check defined in the
  parent module, `activitypub.user_authenticated_and_has_actor_check`), plus
  `ActivityPubApiRestMediaBase.php` for media resources.
- **Traits**: `src/Traits/ActivityPubApiTrait.php` (`getRawBaseRoute` with
  `_content_type_format: form|json`, `handleFileUploads`, `getInstanceInformation`, `logPayload`,
  `logResponse`), `src/Traits/ActivityPubApiOauth2Trait.php` (`createConsumer`, `deleteOauth2Token`).
- **Middleware**: `src/StackMiddleware/OauthTokenRequestBodyParser.php` — converts a JSON body on
  `POST /oauth/token` to form-encoded so Simple OAuth can read it (toggled by
  `convert_oauth_access_token_requests`, wired in `ActivitypubApiServiceProvider`).
- **Services**: `activitypub_api.response` (`Services/ActivityPubApiResponse.php`),
  `exception.unimplemented_endpoint` (`EventSubscriber/UnimplementedEndpointSubscriber.php`).
- **Event**: `src/Event/ApiEntityPreSaveEvent.php`.

## Routes (`activitypub_api.routing.yml`)
- `activitypub_api.settings` `/admin/config/services/activitypub/api` — `administer activitypub settings`.
- `activitypub_api.user` `/user/{user}/activitypub/api` — `user.update` + `currentUserAndActivityPubPermissionCheck`.
- `activitypub_api.user.delete_token` `/user/{user}/activitypub/api/delete/{oauth2_token}` —
  `user.update` + `userApiManageConnectionsAccess`.

## Permissions & install
Permission `manage activitypub api connections`. `hook_install()` grants authenticated users
`grant simple_oauth codes` + `manage activitypub api connections`. `hook_requirements()` checks the
configured upload directory (`file_directory`).

## Config (`activitypub_api.settings`)
`convert_oauth_access_token_requests`, `file_directory` (default `public://activitypub-api-upload`),
`file_extensions`, `file_maxsize`, `instance_name`/`instance_description`/`instance_email`,
`log_payloads`, `log_responses`, `log_status_errors`, `log_unimplemented_endpoints`.

## Solution doc
- REST/OAuth2 base & operating notes: [agent/api/rest.md](api/rest.md)
