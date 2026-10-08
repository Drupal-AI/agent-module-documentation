<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands — `AcquiaCmsHeadlessCommands`

`src/Commands/AcquiaCmsHeadlessCommands.php`, registered via `drush.services.yml`
(`acquia_cms_headless.commands`), injecting `acquia_cms_headless.starterkit_nextjs`,
`entity_type.manager`, `file_system`. `composer.json` `extra.drush.services` maps this file for
Drush 10+.

## `acms:headless:new-nextjs`

Options: `--site-url`, `--site-name`, `--env-file`. Provisions a Next.js backend.
- If **no** `next_site` exists: runs `StarterkitNextjsService::initStarterkitNextjs($site_id,
  $data)` (full provisioning — user, OAuth keys, consumer, site, entity types), then logs the env
  vars.
- If one already exists: only `createHeadlessConsumer()` + `createHeadlessSite()` for the new one.
- `$site_id` derives from `--site-name` via `getSiteMachineName()` (`strtolower` +
  `preg_replace('/[^a-z0-9_]+/','_')`).

`@hook validate` (`validateAcmsHeadlessNewNextJs`): requires both `--site-url` and `--site-name`,
and errors if a site with the derived machine name already exists.

Example: `drush acms:headless:new-nextjs --site-url='http://localhost:3000' --site-name='Headless site'`

## `acms:headless:regenerate-env`

Options: `--site-url`, `--env-file`. Rotates the consumer secret for the consumer whose `redirect`
matches `--site-url` (`getHeadlessConsumerDataByUri()`), sets the new secret on the consumer
(`createHeadlessSecret()` → `set('secret', …)` + `setConsumerSecret()` so the env dump can include
it), saves, then logs the env vars for the matching `next_site`.

`@hook validate` (`validateAcmsHeadlessRegenerateEnv`): requires at least one `next_site` to exist,
requires `--site-url`, and verifies a site + consumer exist for that URL.

## Env-file handling

When `--env-file` is given, `logMessage()` `file_put_contents()`s the env-var string to it; else it
logs the values as a notice. `prepareEnvironmentFileDirectory()` / `getDefaultFileName()` default
the file to `../.env.local` (one directory up, i.e. outside docroot) and create the parent
directory if needed.
