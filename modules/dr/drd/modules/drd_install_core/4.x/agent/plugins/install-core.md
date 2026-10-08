<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The DRD Core Installer webform handler

## Install

```bash
drush en drd_install_core -y
```

Requires `drd`, `webform` and `gitlab_api`. Ships an example webform
`webform.webform.add_new_drupal_site` (`config/install/`) you can clone.

## Building the intake webform

1. Create a webform with fields for: user id, host id, a field to store the created core id, a field
   to store the domain-secrets payload, site name, and site URL (use the **DRD Domain** element,
   `id = drd_domain` — a subclass of Webform's `Url`).
2. Add the **DRD Core Installer** handler (`id = drd_core`) and map each of the above to a webform
   key via the handler settings form (`InstallCore::buildConfigurationForm()`).

## Handler configuration keys (`InstallCore::defaultConfiguration()`)

Field mappings: `field_user_id`, `field_host_id`, `field_core_id`, `field_domain_secrets`,
`field_site_name`, `field_site_url` (all required selects of webform elements). Plus fixed values:
`drupal_root` (target Drupal root, token-replaced), `http_header` (YAML, decoded into the domain's
`header` key/value field), `shared_secret`, `openssl_cipher`, `openssl_password`.

## What runs on submission (`InstallCore::postSave()`)

Only when `!$update` and the submission state is `STATE_COMPLETED`:

1. `Core::create()` with `user_id`, `name`, `status = 1`, `host`; save; store the new core id back
   into `field_core_id`; set `drupalroot` (token-replaced, trailing `/` trimmed); save again.
2. `Domain::instanceFromUrl($core, $uri, [])` for the token-replaced site URL; set name, the decoded
   `header`, `installed = 1`, `auth = shared_secret` + `setAuthSetting(['shared_secret' =>
   ['secret' => …]])`, `crypt = OpenSsl` + `setCryptSetting(['OpenSsl' => ['cipher' => …,
   'password' => …]])`; save. (The setters encrypt these via the base `drd.encrypt` service.)
3. Build `field_domain_secrets` = `json_encode(['authorised' => [uuid => [uuid, auth, authsetting,
   crypt, cryptsetting, redirect, drdips, timestamp, ip]], 'ott' => []])` — the payload the new
   site's DRD Agent uses to authorise this dashboard. `ip` comes from `$_SERVER['SERVER_ADDR']`.
4. `resave()` the submission.

Exceptions are caught and ignored (`@todo Log this exception`).

## GitLab integration (`EventSubscriber\CreateProject`)

Subscribes to `gitlab_api`'s `GitLabEvents::CREATEPROJECT`. On the event it reads the submission's
`drd_core` handler config, loads the core by `field_core_id`, and calls
`Core::setGitRepo($project['ssh_url_to_repo'])` so the created repository is recorded on the core.

## Operational note

The handler configuration holds the shared secret and OpenSSL password in plain webform-handler
config, and the assembled secrets are also written into the submission's `field_domain_secrets`.
Treat the intake webform, its handler config and its submissions as sensitive (restrict who can
view submissions and edit the webform), since they carry dashboard-to-agent credentials.
