<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Activities

Three admin forms, all writing the single config object `activities.settings`:

| Route | Path | Form | Permission |
|---|---|---|---|
| `activities.config_form` | `/admin/config/activities` | `ActivitiesAllowedType` — what to log | `administer users activity` |
| `activities.purge_config_form` | `/admin/config/activities/purge` | `ActivitiesPurgeConfigForm` — auto-purge | `administer users activity` |
| `activities.manual_purge_form` | `/admin/config/activities/purge/manual` | `ActivitiesManualPurgeForm` — one-off purge | `purge activities` |

`activities.settings` ships **empty** — with no config, nothing is logged.

## What to log (per entity type)

For each content entity type the config gets a key whose value is a map of the four operations
plus optional bundles:

```yaml
# activities.settings
node:
  create: create        # enabled = the op string; disabled = 0
  update: update
  delete: 0
  view: 0
  bundles:              # optional; empty/absent = all bundles
    - article
```

The CRUD hooks only log an operation when `config->get('<entity_type>')['<op>'] != 0`. Enabling
**`view`** logs on *every* page view of that entity type — heavy; use with care.

## Security (view-tracking protection)

Under the `security` key of the same config:

| Key | Type | Default | Meaning |
|---|---|---|---|
| `view_throttle_window` | integer (secs) | `60` | Suppress duplicate view logs from the same user on the same entity within this window (0 = off). |
| `exclude_anonymous_views` | boolean | `true` | Don't log views by anonymous users (reduces spam/DoS surface). |

## Purge (`purge` key, runs on cron)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `purge_method` | string | `never` | `never`, `time_based`, or `count_based`. |
| `time_value` | integer | `30` | (time_based) delete entries older than this many `time_unit`s. |
| `time_unit` | string | `days` | (time_based) unit for `time_value`. |
| `count_limit` | integer | `10000` | (count_based) keep at most this many entries; oldest deleted first. |

`activities_cron()` calls `activities.purge`→`executePurge()` each run.

## Drush / snippets

```bash
# Log node create + delete (all bundles)
drush php:eval '$c=\Drupal::configFactory()->getEditable("activities.settings");
  $c->set("node", ["create"=>"create","update"=>0,"delete"=>"delete","view"=>0])->save();'

# Time-based purge: delete activities older than 90 days
drush php:eval '$c=\Drupal::configFactory()->getEditable("activities.settings");
  $c->set("purge", ["purge_method"=>"time_based","time_value"=>90,"time_unit"=>"days","count_limit"=>10000])->save();'

# Read current settings
drush config:get activities.settings
```

## Permissions (`activities.permissions.yml`)

| Permission | Gates |
|---|---|
| `can view users activity` | Viewing the activity log / `user_activities` entities. |
| `administer users activity` | The config + purge-settings forms. |
| `purge activities` | The manual purge form (`restrict access: true`). |
