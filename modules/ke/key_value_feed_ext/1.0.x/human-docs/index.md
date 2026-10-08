# Key Value Field Feeds Extension — manual setup guide

**Key Value Field Feeds Extension** (`key_value_feed_ext`) is the bridge between the
[Feeds](https://www.drupal.org/project/feeds) module and the
[Key Value Field](https://www.drupal.org/project/key_value_field) module. Out of the
box, Feeds can't map imported data into key/value fields; this module adds the
**Feeds target plugins** that make it possible, so an importer can populate a
`key_value` (plain text) or `key_value_long` (formatted text) field directly.

Once enabled, two new target types appear in your Feed Type mappings — one for each
field type. Each target exposes the field's sub‑properties so you can map incoming
source columns to them: a **key** (required and indexed), a **value**, and an
optional **description**. The `key` can be marked **unique**, which lets Feeds use
it as a de‑duplication target so re‑imports update existing rows instead of creating
duplicates. Rows whose key comes in blank are skipped automatically, and imported
values are trimmed and cast to strings.

The module has no settings form, no routes, no permissions, and makes no external
calls — it's purely a set of mapping plugins you use inside a Feeds importer. It
depends on both **Feeds** and **Key Value Field**, and supports Drupal 9, 10, and
11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it with
   Feeds and Key Value Field.

There is **no configuration page** for this module — it adds no settings form. You
use it inside a Feeds importer's mappings, described in "How to use it" below.

## Where it lives in the admin menu

The module adds no admin page. You use it from your Feed Type's **Mapping** tab
under **Structure → Feed types** (`/admin/structure/feeds`).

## How to use it

1. Create or edit a **Feed Type** at **Structure → Feed types** and open its
   **Mapping** tab.
2. Add a new mapping and choose one of the two targets this module provides:
   - **Key Value (Plain Text)** — targets a `key_value` field.
   - **Key Value Long (Formatted Text)** — targets a `key_value_long` field.
3. Map your source columns to the target's sub‑properties: **key** (required —
   consider marking it *unique* so it de‑duplicates), **value**, and optionally
   **description**.
4. For the **Key Value Long** target, click the settings gear on the mapping to
   choose the **Text format** (for example *Basic HTML* or *Full HTML*) that will be
   applied to every imported value.
5. Run the importer. Items with a blank key are skipped automatically, and keys are
   trimmed before use.
