# Single Content Sync — manual setup guide

**Single Content Sync** (`single_content_sync`) exports a **single content
entity** — and the entities it references — to a YAML file or a ZIP bundle, and
imports it on another site. It's a lightweight way to move an individual piece of
content between environments (staging to production, say) without setting up a
full migration.

Once enabled, the module adds an **Export** tab to fieldable content entities:
nodes, media, taxonomy terms, block content, menu link content, and any other
entity type you allow. From the export form you preview the entity serialized as
YAML and download it either as a plain `.yml` file or as a `.zip` that also
bundles referenced assets like files and images. Referenced entities are followed
recursively, so a node's paragraphs, media, terms, links, and embedded content
travel with it. An "export mode" setting decides whether embedded and menu links
come across as lightweight **stubs** (matched by UUID on the destination) or as
**full** entities.

Importing happens at **Content → Import**, where you paste YAML or upload a
`.yml`/`.zip`. There are also Drush commands (`content:export` and
`content:import`) for bulk and scripted transfers — with flags for translations,
assets, bundles, specific entity IDs, and dry runs — and a programmatic importer
service that's handy for importing content on deploy from a `hook_update_N`.
Developers can extend how specific field types and entity types are handled via
processor plugins and events. A settings form controls which entity types and
bundles may be exported, a source/destination site‑UUID safety check, and the file
directories used during import/export.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and note the PHP extension requirements.
2. [Configuration](configuration/index.md) — the settings form, the per‑entity
   Export tab, the Import page, bulk export, and permissions.

## Where it lives in the admin menu

- **Settings:** Configuration → Content → Single Content Sync
  (`/admin/config/content/single-content-sync`).
- **Import:** Content → Import (`/admin/content/import`).
- **Export:** an **Export** tab on each allowed content entity (for example
  `/node/{id}/export`).

## How to use it

1. On any allowed content entity, click its **Export** tab. Review the YAML
   preview, optionally tick **Include all translations**, then choose **Download
   as a file** (YAML only) or **Download as a zip with all assets**.
2. On the destination site, go to **Content → Import**, and paste the YAML or
   upload the `.yml`/`.zip`. Submit to recreate the content and its dependencies.
3. For bulk or scripted transfers, use the `drush content:export` /
   `drush content:import` commands (see the
   [`agent/drush`](../agent/drush/single_content_sync.md) doc).
