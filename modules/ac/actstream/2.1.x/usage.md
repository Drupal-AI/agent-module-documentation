<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Activity Stream aggregates a user's web activity from external services (RSS/Atom feeds, social networks, any service you wire up) into native Drupal `actstream_item` content entities, rendered as *Actor VERB Object* statements.

---

It creates the `actstream_item` entity type and an `actstream_account` table on install. Any module registers a service in `hook_actstream_services()`, adds per-user credential fields to the accounts form via `hook_form_actstream_accounts_form_alter()`, and fetches items in `hook_actstream_SERVICE_items_fetch()`. A Drush command and a cron hook iterate saved accounts, call the fetch hooks, and persist new items. Ten optional sub-modules ship service integrations (Twitter, Instagram search, Last.fm, Flickr, Facebook page, RSS feed, wall, mod queue, etc.).

Operationally: place the Activity Stream block or visit `/actstream` (site-wide) and `/user/{uid}/actstream` (per-user). Both listing pages load only published items with entity access checks. Account credentials are stored serialized in the `actstream_account` table and unserialized on read; the per-user accounts form lives at `/user/{user}/edit/actstream`. Fetch runs on cron or via the `actstream:fetch` Drush command.

---

- Enable the module and view the site-wide stream at `/actstream`
- View a single user's activity at `/user/{uid}/actstream`
- Edit a user's connected service accounts at `/user/{uid}/edit/actstream`
- Place the Activity Stream block in a region
- Enable a service sub-module (e.g. `actstream_twitter`, `actstream_feed`)
- Register a new service type with `hook_actstream_services()`
- Add per-user credential fields via `hook_form_actstream_accounts_form_alter()`
- Fetch and normalise remote items in `hook_actstream_SERVICE_items_fetch()`
- Filter or enrich fetched items in `hook_actstream_SERVICE_items_alter()`
- Adjust item rendering in `hook_preprocess_actstream_item()`
- Save fetched items programmatically with `actstream_items_save()`
- Load stream items with `actstream_items_load($uid)`
- Save per-user account data with `actstream_account_save()`
- Trigger a fetch for all accounts via the Drush command
- Run fetches automatically on cron
- Override the `actstream-item.html.twig` template per service
- Grant "Administer Activity Stream" to editors who curate items
- Restrict item management with the two provided permissions
- Theme statements per service with `actstream_item__SERVICE` theme hooks
- Build a lifestream/profile aggregation page from multiple services
- Delete account data with `actstream_account_delete()`
