# Configuration

There are two places to configure preview: a **site-wide settings form** and a
**per-index setting** on each Elasticsearch content index.

## Site-wide settings

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Search and metadata → Elasticsearch Helper → Preview**
   (`/admin/config/search/elasticsearch_helper/preview`).
3. Set:
   - **Front-end application base URL** — the base URL of your decoupled app. The
     editor is redirected here (base URL + preview path) when they preview content.
     This is admin-configured, not taken from user input, which is part of what
     keeps the redirect safe.
   - **Preview index expiration** — how long a temporary preview index entry lives
     before it's eligible for cleanup. Expired preview indices are dropped on cron,
     so keep cron running.

## Per-index preview settings

Preview is turned on for each content index individually:

1. Edit an Elasticsearch **content index** (an `elasticsearch_content_index`).
2. Check **Enable preview**.
3. Set a **Preview path** template — the path on the front-end app that renders a
   preview. The template accepts placeholders for the index and document, for
   example `/preview/{_index}/{_id}`, as well as field-name placeholders.
4. Save.

## How previewing works for editors

Once an index has preview enabled, the node edit form for that content gains a
**preview button**. When an editor clicks it:

1. The current (possibly unsaved) form values are built into a document and stored
   in the editor's **private tempstore**, and staged into a temporary Elasticsearch
   index.
2. The editor is redirected to the front-end app at the configured base URL plus the
   configured preview path, where the app reads the temporary document and renders
   the preview.

## Access and safety

- **Only users who can edit the entity can follow a preview link.** The preview
  route checks update access on the entity, so draft and unpublished content is not
  exposed to unauthorized visitors.
- **The redirect target is admin-configured**, built from the base URL plus the
  configured path — not from raw user input — so it can't be turned into an
  open-redirect.
- **The payload lives in the per-user private tempstore**, and temporary preview
  indices expire and are garbage-collected on cron, so drafts don't leak into the
  live index or linger.

Because preview stages content into Elasticsearch, the usual Elasticsearch caution
applies: make sure the cluster is reachable only by the site and kept behind your
network boundary over TLS.
