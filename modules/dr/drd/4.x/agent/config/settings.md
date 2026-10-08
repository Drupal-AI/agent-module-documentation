<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration, install and shipped config

## Install / enable

```bash
composer require drupal/drd
drush en drd -y
```

Pulls in `advancedqueue`, `drd_agent`, `encrypt`, `eva`, `key_value_field` and core `taxonomy` /
`update` / `views`. `drd_install()` creates a default **"Localhost"** `drd_host` and a `tags`
taxonomy vocabulary. **Before connecting any site**, create an Encrypt encryption profile (the
module recommends `real_aes`) and select it at `/drd/settings` — until then secrets are stored
unencrypted (see [../api/crypto-and-auth.md](../api/crypto-and-auth.md)). Each remote site must have
the `drd_agent` module installed and be authorised from the dashboard.

## Settings form (`Form\Settings`, `/drd/settings`, config `drd.general`)

Editable config object is `drd.general` (defaults in `config/install/drd.general.yml`):

| Key | Default | Meaning |
|---|---|---|
| `encryption_profile` | (none) | Encrypt profile used for all at-rest DRD secrets (required). |
| `debug` | `false` | Debug logging mode. |
| `lock_hacked` | `false` | Automatically lock releases flagged by the Hacked! module. |
| `cleanup.releases` | `false` | Delete unused releases during cron. |
| `cleanup.majors` | `false` | Delete unused major versions during cron. |
| `cleanup.projects` | `false` | Delete unused projects during cron. |
| `local.db.user` | `''` | DB username for local-copy operations. |
| `local.db.pass` | `''` | DB password for local copy — **stored encrypted** via `drd.encrypt`. |
| `remote_blocks` | `[]` | Configured remote blocks to render on the dashboard. |

Changing `encryption_profile` triggers `EncryptionUpdate::update()` to re-encrypt every stored
secret with the new profile.

## Cron

`drd_cron()` runs `Cleanup::execute()` (`drd.cleanup`), which honours the `cleanup.*` flags to prune
unused releases/majors/projects.

## Config schema and shipped config

- `config/schema/` — `script_code.schema.yml`, `script_type.schema.yml`, and Views filter schemas
  (`drd_cores`, `drd_core_versions`, `drd_hosts`, `drd_major_versions`, `drd_project_type`,
  `drd_update_status`).
- `config/install/` — `drd.general.yml` and the Advanced Queue queue `advancedqueue.advancedqueue_queue.drd`.
- `config/optional/` — default view displays for the entities, the Views (`drd_core`, `drd_domain`,
  `drd_host`, `drd_project`, `drd_domains_per_project`, `drd_errors_per_domain`,
  `drd_releases_per_domain`, `drd_warnings_per_domain`, `drd_requirement`), the shipped
  `drd.script_type.*` (drush / drupal_console / php / python / shell_script), and every
  `system.action.drd_action_*` action config entity.
- `config/translations/drd.en.yml` — bundled English strings.

## Update hooks (`drd.install`)

`8001` fixes major versions; `8002` refreshes view definitions; `8003` re-runs
`resetCryptSettings()` for every domain (rotates transport keys); `8004` adds the `gitrepo` field to
cores; `8005` deletes the old library action; `8006` drops a redundant host field; `8007` recreates
the `tags` vocabulary; `8008` normalises crypt class names (`OpenSSL`→`OpenSsl`, `MCrypt`→`Mcrypt`,
`TLS`→`Tls`).
