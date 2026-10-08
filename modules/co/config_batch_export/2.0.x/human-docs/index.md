# Config Batch Export — manual setup guide

**Config Batch Export** (`config_batch_export`) adds a second way to download your
full site configuration archive: instead of exporting everything in a single
request, it runs the export through Drupal's Batch API, processing the work in
chunks. That matters on large sites — if you have hundreds or thousands of config
files, the normal one-shot export can exceed PHP's execution time or memory, and
on hosts or CDNs that cap server response time (often at 30 seconds) the download
simply times out. Batching the work sidesteps those limits, and the archive is
only gzipped at the very end, which keeps the whole operation fast and light on
RAM.

The module works the moment you enable it — there is no settings form to fill in.
It simply adds an **Export in batch** button to Drupal's existing configuration
export page. It depends only on core's Configuration, File, and Datetime modules.

There is one prerequisite worth calling out: Config Batch Export writes the
generated archive to Drupal's **private filesystem**, so you must have the private
file path configured in `settings.php` before you use it. Storing the file
privately is a deliberate safety choice — configuration can contain sensitive
values, and the module deletes the archive during garbage collection after its
first download rather than leaving it sitting in a temporary, world-readable
folder. Treat any config archive you download the same way: review it before
committing, and keep it out of public locations.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and configure the private file path it needs.

There is **no configuration page** for this module — it has no settings form. Once
enabled, its single button lives on the standard config export page, described
below.

## Where it lives in the admin menu

Config Batch Export adds no admin page of its own. Instead it adds an **Export in
batch** button to the standard full configuration export screen at
**Configuration → Development → Configuration synchronization → Export → Full
archive** (`/admin/config/development/configuration/full/export`).

## How to use it

1. Make sure the private filesystem is configured (see
   [Installation](installation/index.md)).
2. Go to `/admin/config/development/configuration/full/export`.
3. Click **Export in batch** and wait for the batch process to finish.
4. When it completes, a status message shows a **download link**. Click it to
   download the configuration archive.
5. The file is served from the private directory and cleaned up automatically
   after that first download, so if you need it again you simply run the batch
   export once more.
