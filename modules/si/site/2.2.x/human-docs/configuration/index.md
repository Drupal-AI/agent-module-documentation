# Configuration

Site works as soon as it is enabled — the Site entity is created and starts
collecting properties. The steps below are about tuning *what* it stores, *when* it
takes snapshots, and *where* (if anywhere) it reports.

## First-run setup

1. Log in as a user with the Site administration permissions (an administrator by
   default).
2. Go to **`/admin/site/about`** to see the current status page, then open the Site
   **Settings** form (linked from there, `/admin/site/settings`).
3. Choose which **state handlers** compute the Site State — core's Status Report,
   Site Audit's checks, and any custom SiteState/SiteProperty plugins you have — and
   pick which **config and state values** are stored on the entity.

## Snapshots and history

The Site entity is revisionable, and snapshots are saved when configuration changes
or on cron, giving you a timeline you can review through the entity's **History**
page. You can also save a snapshot on demand. Because the entity is fieldable, you
can add your own fields (via Field UI) to record anything else you want kept with each
snapshot and shown on connected dashboards.

## Setting the state from scripts

If your own monitoring decides whether the site is healthy, Site ships **Drush
commands** to set the Site **state** (OK / Warning / Error) and a **reason** string
from the command line. Run your check, set the state and reason, and the value feeds
the entity and its saved revisions — combine it with the cron/report settings so the
result is snapshotted or sent onward automatically.

## Remote reporting to a Site Manager

To gather reports from many sites or environments in one place:

1. On the Settings form, configure a **Site Data Destination** — another site or a
   Site Manager instance (self-hosted, or the hosted Sites.Watch service).
2. The module's remote service then POSTs this site's data to that destination, on
   cron or on demand, building a central CI/operations dashboard.
3. Optionally allow **Site Overrides**: a receiving Site Manager can push back
   overrides for selected config, fields, or state. Choose exactly which of these are
   permitted on the Settings form — nothing is overridable unless you allow it.

## The Site API and permissions

Site data is exposed over JSON:API:

- **`GET /jsonapi/self`** returns this site's entity data — requires the `access site
  data api` permission.
- **`POST /jsonapi/action/{plugin_id}`** runs a Site Action plugin — requires the
  `access site actions pages` permission.

Both endpoints accept basic-auth, cookie, `key_auth` (API key), and IP-consumer
authentication, so you can let a central manager authenticate with a key rather than a
login. Grant the API permissions only to the roles or consumers that need them.

One permission deserves special care: **`bypass site action user login password
requirement`** relaxes the password check on the built-in User Login site action
(used for features like remote login from a Site Manager). Grant it only when you
deliberately want that convenience, and to trusted operators only.
