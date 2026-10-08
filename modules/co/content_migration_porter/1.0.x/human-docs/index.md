# Content Porter — manual setup guide

**Content Porter** (machine name `content_porter`, from the drupal.org project
**Content Migration Porter**, `content_migration_porter`) moves actual content
between two Drupal sites using a plain **JSON export and import**. You select
content on the source site, export it to a JSON file, then upload that file on the
destination site to recreate the content there. It's a lightweight way to move a
content tree — say, an article with its paragraphs and images — from staging to
production without standing up a full migration framework.

Content Porter carries the **content data**, including a node's referenced
paragraphs, taxonomy terms, media, and the underlying image/files, and it can
export custom blocks (marked reusable for Layout Builder on import). It does **not**
recreate site structure: content types, fields, paragraph types, media types,
vocabularies, and custom block types must already exist on the destination site
before you import. If the structure is missing, the importer validates and aborts
with an error rather than guessing. For moving structure first, the maintainers
recommend the *Config Entity Exporter* module, then Content Porter for the content.

The module installs on **both** the source and the destination site. Its one
dependency is core's **Serialization** module.

Both the export and import screens require the **Administer site configuration**
permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer on both sites and
   enable the module.

There is **no settings form** for this module. You use it through its two admin
action pages, described below.

## Where it lives in the admin menu

Content Porter adds two pages:

- **Export content** at `/admin/content-export`
- **Import content** at `/admin/content-import`

(In the project's own words these live under **Content → Content Porter**.) Both
require the **Administer site configuration** permission.

## How to use it

The typical staging-to-production flow:

1. **Prepare the destination structure first.** Make sure the destination site
   already has the same content types, field machine names and types, paragraph
   types, media types, vocabularies, and custom block types as the source. If it
   doesn't, migrate the configuration first (for example with *Config Entity
   Exporter*).
2. **Export on the source site.** Go to **Export content** (`/admin/content-export`).
   Choose the entity type to export (content, custom block, or media), then the
   bundle/type, then tick the specific items you want. Submit the form to generate a
   JSON file, and download it. The export automatically includes each item's
   referenced paragraphs, taxonomy terms, media, and files (recording each file's
   source download URL).
3. **Import on the destination site.** Go to **Import content**
   (`/admin/content-import`) and upload the JSON file. Content Porter first
   validates that every required bundle, field, paragraph, and term exists on the
   destination — aborting with a message if anything is missing — then recreates the
   entities in dependency order (paragraphs, terms, files, media, nodes, then block
   content) and re-links their references. Any file missing on disk is fetched from
   the source URL recorded in the JSON.
