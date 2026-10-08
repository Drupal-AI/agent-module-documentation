# Tamper Bin to File — manual setup guide

**Tamper Bin to File** (`feeds_tamper_bin_to_file`) provides a
[Tamper](https://www.drupal.org/project/tamper) plugin that converts binary field
data into a Drupal file reference during import. When your source delivers a file's
raw bytes inline (rather than a URL or a path), this tamper takes that binary blob
and turns it into a managed Drupal file so the value can populate a file or image
field.

A Tamper plugin transforms one source value as it flows through the import
pipeline, so this plugin is added to the specific field that carries the binary
data and configured there — it has no settings page of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Tamper.

There is **no site-wide configuration page** for this module — it has no settings
form of its own. The plugin is configured as a tamper instance on a Feed type, as
described below.

## Where it lives in the admin menu

The plugin adds no admin page of its own. You use it from a Feed type's **Tamper**
tab at **Structure → Feed types** (`/admin/structure/feeds`).

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Create or edit a Feed type, and map the source key that carries the binary data
   to a file (or image) field on your target entity.
3. Open the Feed type's **Tamper** tab, and on that field add the Bin to File
   plugin.
4. Create a feed of that type and import — the binary data is converted into a
   Drupal file reference as it is saved.
