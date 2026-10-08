# Configure link checking

![Link checker settings form](../../../../../../../screenshots/linkchecker/2.1.x/linkchecker.png)

## Which fields / entities are scanned

Link checker does not scan everything by default — you opt fields in.

- **Per field:** on each field's config form (`hook_form_field_config_form_alter` adds a
  "Link checker settings" section) tick **Scan broken links** and pick an **Extractor**.
  Stored as `field.field.*.*.*.third_party.linkchecker.scan` (bool) and `.extractor`
  (plugin id). Any fieldable entity type (nodes, etc.) is supported.
- **Blocks:** enable `scan_blocks` to also extract links from custom block content.
- **Published only:** `search_published_contents_only` ignores links in unpublished content.
- Links are extracted on entity insert/update (`hook_entity_insert`/`update`) and in bulk on
  cron; each unique URL becomes a `linkcheckerlink` entity in the `linkchecker_link` table.

## Settings form — `linkchecker.settings`

At `/admin/config/content/linkchecker` (route `linkchecker.admin_settings_form`,
form `LinkCheckerAdminSettingsForm`) or via `drush cset linkchecker.settings <key>`.
Defaults from `config/install/linkchecker.settings.yml`:

| Key | Default | Meaning |
|---|---|---|
| `check_links_types` | `1` | Which links to check: 1 = internal + external, 2 = external only, 3 = internal only |
| `default_url_scheme` | `http://` | Scheme for scheme-relative links |
| `base_path` | `''` | Base host for resolving internal URLs (e.g. `www.example.com`) |
| `scan_blocks` | (unset) | Also scan custom blocks |
| `search_published_contents_only` | (unset) | Ignore links in unpublished content |
| `extract.from_a` | `true` | Extract `<a>`/`<area>` links |
| `extract.from_img` | `false` | Extract `<img>` sources |
| `extract.from_iframe` / `from_audio` / `from_video` / `from_object` / `from_embed` | `false` | Extract those tags |
| `extract.filter_blacklist` | list | Text filters excluded from extraction (filter_align, smiley, …) |
| `check.connections_max` | `8` | Max simultaneous HTTP connections |
| `check.connections_max_per_domain` | `2` | Max simultaneous connections per domain |
| `check.disable_link_check_for_urls` | example.* | Hosts (one per line) whose links are not checked |
| `check.library` | `core` | HTTP check library |
| `check.interval` | `2419200` | Re-check interval in seconds (4 weeks) |
| `check.useragent` | `Drupal (+http://drupal.org/)` | User-Agent for requests |
| `error.action_status_code_301` | `0` | If set, repair permanently-moved (301) links (`repair_301` handler) |
| `error.action_status_code_404` | `0` | Unpublish content after this many 404 failures (`unpublish_404` handler) |
| `error.ignore_response_codes` | `200 206 302 304 401 403` | Codes NOT treated as broken |
| `error.impersonate_account` | `''` | Account to impersonate when checking internal links |
| `logging.level` | `6` | Watchdog logging verbosity |

Config is a `config_object` (schema `config/schema/linkchecker.schema.yml`), so it
exports/deploys with `drush config:export`.

## Cron / queue-based checking

`hook_cron` (`linkchecker_cron`) does two things each run:

1. `linkchecker.extractor_batch->processEntities()` — extracts links from not-yet-indexed
   entities.
2. `linkchecker.checker->queueLinks()` — queues links whose `check.interval` has elapsed.

Two queue workers drain on cron and perform the actual HTTP checks / follow-up actions:

| Queue worker id | Cron time | Role |
|---|---|---|
| `linkchecker_check` | 240s | Sends the request, records response code / method / error on the link |
| `linkchecker_status_handle` | 60s | Runs matching `LinkStatusHandler` plugins (301 repair, 404 unpublish) |

HTTP behaviour is tuned by the `check.*` settings above (concurrency, per-domain cap,
User-Agent, ignored hosts). For internal-URL checks, cron must run against the real public
site URL (see README) or links may be falsely reported broken.

## The broken-links report

Results are shown by the `broken_links_report` view (`config/optional/`) — a page display at
**`/admin/reports/linkchecker`** over `base_table: linkchecker_link`, gated by the
`access broken links report` permission. It lists the owning entity, URL, last check time,
method, HTTP code and error.

## Drush

- `drush linkchecker:analyze` (alias `lca`) — re-extract from all entities and re-check.
- `drush linkchecker:clear` (alias `lccl`) — clear all stored links.
