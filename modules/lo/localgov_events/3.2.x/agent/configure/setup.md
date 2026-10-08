<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Setting up events

## Install

```bash
composer require drupal/localgov_events
drush en localgov_events -y
# Optional: automatic clean-up of finished events
drush en localgov_events_remove_expired -y
drush cr
```

Dependencies: core `link`, `path`, `taxonomy`, `views`, plus contrib `date_recur`,
`date_recur_modular` and `facets`.

## The bundle

`localgov_event`:

| Field | Type | Notes |
|---|---|---|
| `localgov_event_date` | **date_recur** | The recurrence rule + occurrences; the whole listing depends on it |
| `localgov_event_image` | image/media | Event image |
| `localgov_event_categories` | taxonomy reference | Drives the category facet |
| `localgov_event_price` | text | Displayed in listings |
| `localgov_event_locality` | text | Short location label |
| `localgov_event_location` | text/reference | Fuller location; can link to a directories venue |
| `localgov_event_call_to_action` | link | Book/register link |
| `body` | text | Description |

```bash
drush cget field.field.node.localgov_event.localgov_event_date
drush cget node.type.localgov_event
```

## Views

| View | Purpose |
|---|---|
| `localgov_events_listing` | Date-filtered browse page with exposed `start` / `end` filters |
| `localgov_events_search` | Keyword search over events |

Two behaviours are applied in `hook_views_pre_view()` **for the view id
`localgov_events_listing` only**:

- Empty `start` → today's date.
- `end` → `strtotime($end . ' + 1 days')`, so an event on the end date is included.

If you clone the view under a new id you lose both; either keep the id and add a display, or
re-implement the pre-view logic.

## Facets

Category facets come from the Facets module and are placed as blocks. Check what exists:

```bash
drush cget facets.facet.localgov_events_facets 2>/dev/null || drush config:status | grep facets
```

## Styling

`hook_page_attachments()` attaches `localgov_events/events-styling` when the current path starts
with `/events`:

```php
if (substr($current_path, 0, 7) == '/events') { … }
```

If your events live under a different path (a language prefix counts — the check runs on the
internal path, so `/events` still matches for the default language), attach the library yourself
from a theme preprocess.

## Directory integration

`hook_modules_installed()` reacts to `localgov_directories_page` / `localgov_directories_venue`
being installed by importing their optional config so an event can reference a venue. Install
order therefore matters slightly: install the directories bundles **before or after** events and
the hook fires either way, but if you install them while config-syncing (`$is_syncing`) the hook
returns early — re-run the optional config install manually in that case:

```bash
drush php:eval '\Drupal::service("config.installer")->installOptionalConfig(NULL, ["config" => "node.type.localgov_directories_venue"]);'
```

## Cleaning up finished events

Enable `localgov_events_remove_expired` and configure it at
`/admin/config/content/expired-events` — see
[../../modules/localgov_events_remove_expired/3.2.x/agent/start.md](../../../modules/localgov_events_remove_expired/3.2.x/agent/start.md).
