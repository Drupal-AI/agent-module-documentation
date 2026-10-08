# Feeds Files by Media — manual setup guide

**Feeds Files by Media** (`feeds_files_by_media`) extends the
[Feeds](https://www.drupal.org/project/feeds) module so an import can pull files
out of a **Media field on the feed type itself**, instead of downloading them from
a remote URL or uploading them separately. It's a neat way to populate a node's
image or file field from media items you've already attached to the feed.

It provides three Feeds plugins that work together:

- A **fetcher**, *Fetch Resource from media field*, which you configure with the
  machine name of a media‑reference field on the feed type.
- A **parser**, *Media field parser*, which reads the referenced media items.
- A **source** plugin that exposes mapping sources for the media field — the
  **target file id**, **file name**, and the **media item id / name / uuid**.

During an import the fetcher returns a lightweight result carrying the configured
field name, the parser resolves the media entities, and you map the resulting
sources onto your destination entity's file/image or reference fields. Because the
files come from already‑uploaded local media entities, the module makes **no
outbound HTTP requests** — there is no remote‑fetch or SSRF surface to worry
about.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Feeds.

There is **no separate settings page** for this module. Everything is set up on a
feed type, described in "How to use it" below.

## Where it lives in the admin menu

Feeds Files by Media adds no admin page of its own. Its fetcher, parser and mapping
sources appear when you create or edit a feed type at **Structure → Feed types**.

## How to use it

1. Create a feed type at **Structure → Feed types**.
2. For the **Fetcher**, choose **Fetch Resource from media field**, and in its
   settings enter the **Machine name of the media field** you'll use (for example
   `field_source_media`).
3. For the **Parser**, choose **Media field parser**.
4. Add a media‑reference field to the feed type whose machine name matches the
   fetcher setting from step 2.
5. On the feed type's **Mapping** tab, add a mapping from the source **Target file
   id of the media field** to your destination file/image field. Open that
   mapping's configuration and set **Reference by → File Id**.
6. Optionally map the other sources — **Target file name**, or the **media item
   id / name / uuid** — for labels or stable references.
7. Run the import from the feed. The files are taken from the media entities
   referenced on the feed; nothing is fetched remotely.
