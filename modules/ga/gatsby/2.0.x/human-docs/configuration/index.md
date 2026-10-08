# Configuration

## Open the settings form

1. Log in as a user with the **Administer gatsby** permission.
2. Go to **Configuration → Web services → Gatsby → Settings**
   (`/admin/config/services/gatsby/settings`).

Nothing is sent to Gatsby until you fill in the URLs and tick at least one entity
type below — the module stays completely inert out of the box.

## The settings, field by field

These all live in the `gatsby.settings` config object.

- **Gatsby server URL** (`server_url`) — the address of your Gatsby site, used by
  the preview button and the iframe preview. You can list several servers separated
  by commas.
- **Preview callback URL** (`preview_callback_url`) — the Gatsby preview webhook
  (e.g. `http://localhost:8000/__refresh` during development). Setting this enables
  preview logging.
- **Incremental build URL** (`incrementalbuild_url`) — the build webhook that
  triggers incremental or full builds when published content changes. Setting this
  enables build logging.
- **Content Sync URL** (`contentsync_url`) — the Gatsby 4 Content Sync base URL (no
  trailing slash), an alternative preview mechanism.
- **Path mapping** (`path_mapping`) — one mapping per line to translate a Drupal
  path into a different Gatsby path (for example mapping the front page's alias to
  `/`). Used by both the preview button and the iframe.
- **Build published content only** (`build_published`, on by default) — when on,
  only **nodes** trigger builds and non-node entities are skipped for the build
  feed.
- **Supported entity types** (`supported_entity_types`) — checkboxes for the content
  entity types (Content, Media, Files, Paragraphs, …) that are sent to Gatsby.
  **Nothing fires until you tick at least one.**
- **Publish private files** (`publish_private_files`, off by default) — when on,
  `private://` files are also sent to the build; by default private files are
  skipped.
- **Log JSON** (`log_json`, off by default) — logs each JSON payload posted to the
  preview server. For debugging only — never leave this on in production.
- **Custom source plugin** (`custom_source_plugin`) — sends an
  `x-gatsby-cloud-data-source` header when you use a source plugin other than
  `gatsby-source-drupal`.
- **Prevent self-referenced entities** (`prevent_selfreferenced_entities`, off by
  default) — skips logging referenced entities of the same type/bundle, which keeps
  Fastbuilds payloads from ballooning.
- **Delete log entities** (`delete_log_entities`, off by default) — turns on cron
  pruning of old Fastbuilds log entities.
- **Log expiration** (`log_expiration`, default 7 days) — how long log entities are
  kept before pruning.
- **Number of items to delete** (`number_items_delete`, default 500) — the maximum
  number of log entities removed per cron run.

Each comma-split URL is validated as a real URL when you save.

## Turn on the preview button per content type

The **Open Gatsby Preview** button only appears once you enable it for a node type,
and only when `node` is among your supported entity types:

1. Make sure **Content** (`node`) is ticked in *Supported entity types* on the
   settings form.
2. Edit a content type at **Structure → Content types → *(type)* → Edit**. A
   **Gatsby Preview** section now appears — tick its option to enable the preview
   button for that type.
3. The button then shows on that type's node edit form **only when** you have both a
   *server URL* and a *preview callback URL* configured, **and** the bundle uses
   **Content Moderation** (otherwise a warning shows and the button stays disabled).

Clicking the button forces the node's `moderation_state` to `draft`, saves it, and
opens the mapped Gatsby preview URL in a new window.

## Inline iframe preview (optional)

For each supported entity type/bundle the module registers a **Gatsby iframe
preview** pseudo-field, hidden by default. To show a live Gatsby-rendered preview
inside the edit/view screen, enable it on the bundle's **Manage display** for a view
mode. It renders an `<iframe>` pointing at your `server_url` plus the entity's mapped
path, so a **server URL** must be configured.

> Known issue: the iframe can conflict with core's BigPipe. If pages misload, disable
> BigPipe or turn the iframe preview off.

## Fastbuilds sync and its permissions — read before granting

Gatsby's incremental sync is served at `/gatsby-fastbuilds/sync/{last_fetch}` and is
gated by two permissions:

- **Sync gatsby fastbuild log entities** — returns the published ("build") records.
- **Sync gatsby fastbuild preview log entities** — additionally returns the
  preview/draft records.

The sync endpoint returns each logged entity's pre-serialized JSON. Treat both as
trusted permissions:

- Grant them only to a dedicated Gatsby build service account.
- Prefer `key_auth` or `basic_auth` over cookie auth for the endpoint.
- Keep **Build published content only** on so non-node entities do not add records to
  the plain build feed.

## Housekeeping

- **Purge the whole Fastbuilds log:** `drush gatsby:logs:purge`.
- **Automatic pruning:** turn on *Delete log entities* and cron will remove records
  older than *Log expiration* in batches of *Number of items to delete*.

## Save

Click **Save configuration**. Changes take effect immediately — the next content
change on a supported entity type will start reaching your Gatsby endpoints.
