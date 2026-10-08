# Configure Voting API

![Voting API settings form](../../../../../../../screenshots/votingapi/4.0.x/settings.png)

## Settings form

- **Route:** `votingapi.admin_settings` — `/admin/config/search/votingapi`
  (the `configure` route). Permission: `administer voting api`.
- **Config object:** `votingapi.settings`.

| Key | Default | Meaning |
|---|---|---|
| `calculation_schedule` | `immediate` | When results are tallied: `immediate` (on each vote), `cron` (recalculate changed entities at cron), `manual` (never auto-tally — for modules managing their own cycle). |
| `anonymous_window` | `86400` | Seconds before two anonymous votes from the same IP hash are treated as distinct. `-1` = never (max dedupe), `0` = always distinct. Allowed values are a fixed list of intervals up to 604800. |
| `user_window` | `-1` | Same rollover, for repeat votes by the same registered user. |
| `delete_everywhere` | `false` | Allow deleting a user's votes cast on entities owned by others when that user is deleted. |

Set via Drush instead of the UI:

```bash
drush config:set votingapi.settings calculation_schedule cron -y
drush config:set votingapi.settings anonymous_window 3600 -y
```

## Vote types (bundles)

Vote types are `vote_type` config entities (bundle of the `vote` entity),
exported with keys `id`, `label`, `value_type`, `description`.

- **Collection UI:** `entity.vote_type.collection` — `/admin/structure/vote-types`
  (permission `administer vote types`).
- **Add:** `/admin/structure/vote-types/add`; **edit:**
  `/admin/structure/vote-types/{vote_type}`.
- Ships one default type `vote` ("Normal vote", `value_type: points`).
- `value_type` is a free string; common values are `points` (e.g. +1/-1) and
  `percent` (star/percentage ratings).

Create one in config as `votingapi.vote_type.<id>.yml` or via the UI. Adding a
vote type lets you record independent rating dimensions (multi-criteria voting)
on the same entity.

## Cron

When `calculation_schedule` is `cron`, `hook_cron` recalculates results for
every entity that received votes since the last run and stores the run time in
state `votingapi.last_cron`.
