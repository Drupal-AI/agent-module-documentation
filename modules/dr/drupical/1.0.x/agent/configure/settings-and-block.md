<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure & place the Events Feed

Drupical has **no admin settings form** (`configure` route is null). You place its block and,
if needed, edit its config object directly.

## The block

- Plugin id: `events_block`, class `Drupal\drupical\Plugin\Block\EventsBlock`, admin label
  **"Events Feed"** (default instance label "Drupal Events and User Groups", shown).
- Access: `blockAccess()` returns allowed only if the account has the **`access events`**
  permission.
- `build()` always renders `limit`-from-config? No — the block calls
  `EventsRenderer::render(5, 0)` with a hard-coded limit of 5 and offset 0. The `limit`
  config key is the fetch/display default used elsewhere (e.g. the load-more route default).

Place it via drush (into the default theme's `content` region):

```bash
drush php:eval '
  \Drupal::entityTypeManager()->getStorage("block")->create([
    "id" => "drupical_events",
    "plugin" => "events_block",
    "theme" => \Drupal::config("system.theme")->get("default"),
    "region" => "content",
    "weight" => 0,
    "settings" => ["id" => "events_block", "label" => "Events Feed", "label_display" => "visible"],
    "visibility" => [],
  ])->save();'
drush cr
```

Grant the permission so the block is visible:

```bash
drush role:perm:add anonymous 'access events'
drush role:perm:add authenticated 'access events'
```

## The settings (config object `drupical.settings`)

| Key | Default | Meaning |
|---|---|---|
| `max_age` | `86400` | Seconds the fetched events are cached in the expirable key/value store (`drupical` collection, `events` key). |
| `cron_interval` | `21600` | Minimum seconds between automatic event re-fetches in `hook_cron`. |
| `limit` | `5` | Number of events to display / page size for load-more. |

All three are plain integers with a `min: 0` range constraint (schema
`drupical.settings`, `FullyValidatable`). Edit them with drush:

```bash
drush cset drupical.settings limit 10 -y
drush cset drupical.settings max_age 3600 -y
drush cset drupical.settings cron_interval 3600 -y
```

## Cron & cache

`drupical_cron()` compares `\Drupal::state()->get('drupical.last_fetch')` against
`cron_interval`; when exceeded it calls `drupical.fetcher->fetch(TRUE)` (force refresh) and
updates the state timestamp. To force a manual refresh: `drush php:eval
'\Drupal::service("drupical.fetcher")->fetch(TRUE);'`. Clearing caches does not clear the
event key/value store; the fetcher re-fetches when the store entry expires after `max_age`.

## Load-more route

`drupical.load_more` → `/events-feed/load-more` (`EventsController::loadMore`), requires
`access events`. Reads `offset`/`limit` query params, appends rendered `drupical_item`
rows to `.events-table tbody`, and replaces/removes the `.events-load-more` button. It is
driven by `core/drupal.ajax` (attached via the `drupical/drupical` library).
