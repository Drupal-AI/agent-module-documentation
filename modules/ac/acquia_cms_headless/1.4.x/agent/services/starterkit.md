<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Starter-kit service — `StarterkitNextjsService`

`src/Service/StarterkitNextjsService.php`, service id `acquia_cms_headless.starterkit_nextjs`.
Injects `config.factory`, `password_generator`, `entity_type.manager`,
`simple_oauth.key.generator` (`KeyGeneratorService`), `messenger`, `%site.path%`, `file_system`,
`request_stack`. Uses `PasswordGeneratorTrait` (from acquia_cms_common). This is the engine behind
the dashboard tour form and the Drush commands.

## Orchestration — `initStarterkitNextjs($site_id, $site_data)`

Called with `$site_data = ['site-name' => …, 'site-url' => …]`. Steps, in order:
1. `createHeadlessUser()` — recreate the headless user if missing.
2. `generateOauthKeys()` — write the OAuth key pair and point Simple OAuth at it.
3. `updateDefaultConsumer(FALSE)` — clear `is_default` on the "Default Consumer".
4. `createHeadlessConsumer($site_data)` — create the app's consumer.
5. `createHeadlessSite($site_id, $site_data)` — create the `next_site` entity.
6. `createHeadlessSiteEntities()` — one `next_entity_type_config` per node type.
7. Store `consumer_uuid` / `user_uuid` into `acquia_cms_headless.settings`.
8. If not CLI, `displayEnvironmentVariables()` prints the `.env` values via messenger.

`resetStarterkitNextjs()` reverses it: deletes the headless user, the `headless` role config, all
non-Default consumers, restores the Default consumer's `is_default`, deletes next sites/entity
types, and clears the two UUIDs.

## Consumer & secret creation

- `createHeadlessConsumer()` builds a `Consumer` with `client_id` = `Crypt::randomBytesBase64()`
  (set once per service instance in the constructor as `$this->clientId`), `secret` =
  `createHeadlessSecret()`, `roles => 'headless'`, `is_default => TRUE`, `redirect` = the site URL,
  and `user_id` = the headless user. Consumers' own field layer hashes the `secret` on save.
- `createHeadlessSecret()` → `self::generateRandomPassword(12)` (12-char random string from the
  acquia_cms_common trait). Used for consumer secrets and Next.js preview secrets.

## Headless user — `createHeadlessUser()`

Creates (if absent) an active user named **`Headless`** (email `no-reply@example.com`) that backs
the OAuth consumer — a password-grant token issued for the consumer acts as this account, so it is
assigned the roles the decoupled front end needs to read and manage content over JSON:API. Review
and tighten this account's roles and credentials for any non-local environment.

## OAuth keys — `generateOauthKeys()`

- Directory: `Settings::get('oauth_keys_directory')` if set, else `getDefaultOauthKeysDirectory()`
  → `../oauth_keys/<sitedir>` locally, or `/mnt/gfs/<group>.<env>/nobackup/oauth_keys/…` on Acquia
  Cloud (via `AcquiaDrupalEnvironmentDetector`). Created/validated by `generateOauthKeysDirectory()`
  (throws `FilesystemValidationException` if not writable).
- `KeyGeneratorService::generateKeys($dir)` writes `public.key` / `private.key`, then the service
  writes those paths into `simple_oauth.settings` (`public_key` / `private_key`).

## Next.js site & entity types

- `createHeadlessSite()` → `next_site` entity with `client_id`, `base_url`, `preview_url` =
  `<site-url>/api/preview/`, `preview_secret` = `createHeadlessSecret()`.
- `createHeadlessSiteEntities()` → for each `node_type`, a `next_entity_type_config`
  `node.<bundle>` with `site_resolver => site_selector` pointing at all `next_site` ids.

## Environment variables — `getEnvironmentVariablesAsString(NextSite)`

Builds `NEXT_PUBLIC_DRUPAL_BASE_URL`, `NEXT_IMAGE_DOMAIN`, `DRUPAL_SITE_ID`, `DRUPAL_FRONT_PAGE`,
and (when a preview secret exists) `DRUPAL_CLIENT_ID`, `DRUPAL_PREVIEW_SECRET`,
`DRUPAL_CLIENT_SECRET` (the last is `$this->consumerSecret` captured at creation, else the literal
`insert secret here`). `displayEnvironmentVariables()` renders this in a `<pre>` status message;
the Drush command can instead write it to an `--env-file`.

## Lookups & helpers

`getHeadlessConsumerData(label)`, `getHeadlessConsumerDataByUri(redirect)`,
`getHeadlessUserData()` (by name `Headless`), `getHeadlessSite(id)`,
`getHeadlessSiteByBaseUrl(url)`, `hasConsumerData()` (any non-Default consumer exists),
`dashboardDestination()` (a `?destination=/admin/headless/dashboard` query array). All entity
queries use `accessCheck(TRUE)`.
