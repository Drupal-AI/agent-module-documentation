<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Diboo core — settings form & config object

`src/Form/SettingsForm.php` (`ConfigFormBase`, form id `diboo_core_settings`), route
`diboo_core.settings` at `/admin/config/system/diboo-settings`, permission
`administer diboo_core configuration`. Menu link `diboo_core.settings` under
*Configuration → System* (weight 10). These are the **defaults used when a new room is created**;
each chain then follows the rules stored on its room.

## Config object `diboo_core.settings`

Schema `config/schema/diboo_core.schema.yml` (`config_object`), install defaults
`config/install/diboo_core.settings.yml`. All keys are integers:

| Key | Default | Form field | Meaning |
|-----|---------|-----------|---------|
| `max_open_chains` | 5 | Maximum number of open chains in a room | empty = no limit |
| `max_open_chains_user` | 2 | Max open chains in a room by the same user | empty = no limit |
| `min_chain_links_between` | 2 | Links added before the same user can add again | required, must be ≥ 0 |
| `min_chain_links_publish` | 35 | Links required to trigger chain publication | required, must be ≥ 2 |
| `max_minutes_chain_lock` | 100 | Max minutes a chain stays locked by a participant | required; needs cron |

## Validation (`validateForm`)

- `max_open_chains`: if set, must be numeric.
- `min_chain_links_between`: numeric and `>= 0` (error text says "bigger than 0").
- `min_chain_links_publish`: numeric and `>= 2`.
- `max_minutes_chain_lock` / `max_open_chains_user`: saved as-is (both may be blank for no limit).

`submitForm` writes all five keys back to `diboo_core.settings`.

## Where the values are consumed

These config values are the **seed defaults for a room's own fields** — the runtime game logic
reads the *room* fields, not this config object directly:

- `diboo_max_open_chains` / `diboo_max_open_chains_user` → `Room::access('new_chain')` open-chain
  limit checks.
- `diboo_min_chain_links_between` → `Chain::access('add_chain_link')` "not the same recent
  contributor" check.
- `diboo_min_chain_links_publish` → `Room::getMinChainLinksToPublish()`, used in
  `ChainLink::postSave` to auto-publish a full chain.
- `diboo_max_minutes_chain_lock` → `Cron::cron()` lock-timeout release.
