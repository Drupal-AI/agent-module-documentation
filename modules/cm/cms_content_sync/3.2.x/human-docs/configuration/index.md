# Configuration

Setting up Content Sync has three parts: registering the site with your
content-sync.io backend, describing what to sync with **Pools** and **Flows**, and
making sure the encryption key that protects your credentials is a real key rather
than the shipped placeholder. Most of the admin screens are embedded from the
backend, so much of the detailed configuration happens over on content-sync.io.

## Before you start

You need a **content-sync.io / Sync Core backend** account with the details it
gives you for registering a site (environment/contract/space/token). Content Sync
cannot sync anything without it.

## Register the site with the backend

1. Log in as a user with the **Administer cms content sync** permission.
2. Go to **Configuration → Web services → Content Sync**
   (`/admin/config/services/cms_content_sync/site`) and follow the embedded
   registration flow, or
3. Register from the command line:

   ```bash
   drush cms_content_sync:register <environment_type> <contract> <space> <token>
   ```

## Replace the encryption key placeholder (important)

Content Sync encrypts your syndication credentials at rest using the bundled
Encrypt / Real AES modules and a key entity (`key.key.cms_content_sync`). The
module ships that key with a **placeholder value that you must replace**.

Treat the key like any other secret: do not commit its real value to version
control. The safest pattern is to keep the key material in an environment variable
and point the key entity at it (via the Key module's environment provider) rather
than storing the raw value in exported configuration.

## Create a Pool

A **Pool** is the shared channel that participating sites connect to. Create one
under the Content Sync admin area (or programmatically), giving it a machine name,
a label, and the **backend URL** of your Sync Core endpoint (something like
`https://example.content-sync.io`). A single site can join several pools to take
part in independent syndication channels.

## Create a Flow

A **Flow** describes what *this* site does: which entity types and bundles it
pushes or pulls, in which direction, and to or from which pools. When you create a
Flow you choose a **variant** — in this 3.2.x release, use the **simple** variant
(it is the one with a working controller). You then configure, per entity type,
which handler serializes it, which pool it belongs to, and whether it is pushed,
pulled, or both.

## Push the configuration to the backend

After creating or changing Flows and Pools, send that configuration up to the Sync
Core backend:

```bash
drush cms_content_sync:configuration-export   # alias: cse
```

## Syncing content

Once registered and configured, content can move in three ways:

- **Automatically** on save, according to your Flow settings.
- **Manually**, from the Content Sync dashboards embedded from the backend
  (including a Manual Pull screen for pulling curated content on demand).
- **In bulk from the CLI**, for example:

  ```bash
  drush cms_content_sync:push my_flow
  drush cms_content_sync:pull my_flow --type=pull-changed
  ```

Other useful commands include `cms_content_sync:reset-status-entities` (to clear
stuck sync-status records after a backend change) and
`cms_content_sync:check-entity-flags <uuid>` (to debug why a given entity did or
did not sync).

## Permissions

Grant these under **People → Permissions**. The human-facing ones:

- **Administer cms content sync** — full control of the whole Content Sync admin
  UI (site, syndication, Flows, Pools). This is an **elevated** permission; give it
  only to trusted administrators.
- **Access cms content sync content overview** — see the content overview pages.
- **Publish cms content sync changes** — publish pending changes.
- **View cms content sync syndication status** — adds a "Sync status" tab on
  content items.
- **Show entity type differences** — compare entity-type definitions between
  connected sites.

There are also several `restful …` permissions that gate the REST resources the
Sync Core backend uses to push and pull entities. These are normally granted to
the dedicated **`cms_content_sync`** user role that ships with the module, **not**
to human users. Be careful: granting the push/import REST permissions to an
untrusted role would let that caller write entities into your site.

## For developers

Content Sync can be extended with custom **entity handlers** and **field
handlers** (to control how a bespoke field type is serialized), and it dispatches
events such as `BeforeEntityPush` and `AfterEntityPull` that other modules can
subscribe to in order to extend the sync payload. It also provides a
`[cms_content_sync:source_url]` token for the canonical source URL of syndicated
content. See the [`agent/`](../agent/start.md) docs for these APIs.
