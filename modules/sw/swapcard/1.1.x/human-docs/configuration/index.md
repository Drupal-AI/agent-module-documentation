# Configuration

All of Swapcard's configuration lives on one form. What it shows depends on which
submodules you have enabled: the base module gives you the connection settings,
and **Swapcard Content** adds the sync options.

## Connect to Swapcard (base module)

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Web services → Swapcard**, or navigate directly to
   `/admin/config/services/swapcard/config`.
3. **Paste your Swapcard API key.** On entry, the form automatically pings the
   Swapcard API to validate that the connection works, so you get immediate
   feedback if the key is wrong.
4. Set the Guzzle connection options as needed:
   - **Base URI** — the GraphQL endpoint the client posts to.
   - **Timeout** — how long a request may take before it is abandoned.
5. Save.

Your API key is stored in `swapcard.settings` configuration and sent on each
request in an `Authorization` header. Requests are outbound‑only and use Guzzle's
default TLS verification. Because the key is in configuration, treat any exported
config as sensitive and keep it out of public version control.

For developers, the base module also exposes a `plugin.manager.swapcard` plugin
type for building and sending GraphQL queries in your own code — see the module's
README and the sibling [`agent/`](../agent/start.md) docs for code examples.

## Sync content (with Swapcard Content enabled)

Enabling the **Swapcard Content** submodule adds more options to the same form.
Visit `/admin/config/services/swapcard/config` again and set your preferences, for
example:

- Choosing which Event's entities to sync.
- Defining fields that have pre‑defined values (the select lists / dropdowns that
  exist on Swapcard) — these are mirrored so their options stay in sync with
  Swapcard.
- Using test response data while you set things up.
- Purging entities.

To synchronise:

- **On demand** — run the **Sync** action from the config form. It maps and
  synchronises Swapcard data into Drupal entities, including the relationships
  between them (each entity references its parent Event, and Sessions reference
  their Exhibitors and Speakers).
- **On cron** — turn on the cron option so the sync runs automatically on schedule.

Because Swapcard responses can be very large (the sync is tested against batches of
around 2,500 nodes, many with attached media), the work runs through a queue
worker rather than all at once. The submodule also ships a **Drush command** so you
can trigger a sync from the command line, and a **purge confirm form** for removing
a synced event and its content.

### A couple of known quirks

- Swapcard **Speakers** are shared between events but do not have a single global
  id, so the module matches them by email and name to avoid duplicating a speaker
  as multiple Drupal nodes — this matching is inherently imperfect.
- An entity's `updatedAt` value reflects only that entity, not its related/child
  entities, so syncing cannot rely on it alone to detect every change.

## Media sync (with Swapcard Content Media enabled)

Enabling **Swapcard Content Media** adds a media image field to the Swapcard
content types and syncs the associated images — event banners, exhibitor logos,
session banners, and speaker photos — as part of the same sync process. There is no
separate form to fill in beyond enabling the submodule.
