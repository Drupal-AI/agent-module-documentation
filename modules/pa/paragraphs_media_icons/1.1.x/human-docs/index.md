# Paragraphs Media Icons — manual setup guide

**Paragraphs Media Icons** (`paragraphs_media_icons`) solves a specific, painful
problem with large Paragraphs sites: config bloat from icons. The Paragraphs
module stores each paragraph type's icon as a **base64-encoded image inside the
configuration YAML**. On a site with 60–80 paragraph types, that can inflate
config exports to tens of megabytes, make `drush cex` crawl, and produce
unreadable git diffs. This module replaces those config-stored icons with
references to **Media entities** instead — turning a 15–50 KB base64 blob into a
simple integer Media ID and shrinking each paragraph type's config by around 99%.

It does this cleanly, using Drupal's third-party settings API rather than
rewriting the Paragraphs config entities (which would break validation). Under the
hood it extends the paragraph-type entity so that its icon URL resolves to the
referenced media, which keeps icons displaying exactly as before — there's no
visible change for editors — and preserves compatibility with the Paragraphs
Previewer widgets (modal, dropdown, buttons).

Two things make it work in practice: a **Media Icon field** you use when editing a
paragraph type, and a pair of **Drush commands** for migrating your existing
icons in bulk. Because icons are now Media entities, they follow core media and
file access; the module adds no access-control role of its own. It requires
**PHP 8.1+**, Drupal **11.3+**, and depends on core **Media**, **File** and the
**Paragraphs** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   run the one-time migration of your existing icons.

There is **no dedicated settings page**. You set a paragraph type's icon on the
paragraph type's own edit form, and you migrate existing icons with Drush — both
described below.

## Where it lives in the admin menu

Paragraphs Media Icons adds no settings screen of its own. You work with it at
**Structure → Paragraphs types**, where each paragraph type's edit form now offers
a **Media Icon** field.

## How to use it

To set an icon on a paragraph type:

1. Go to **Structure → Paragraphs types** and edit a type.
2. Use the **Media Icon** field to select an image from the Media Library.
3. Save. The icon appears wherever Paragraphs icons normally display.

To convert the icons you already have from base64 config to Media entities, use
the Drush commands (safe to run more than once):

- `drush pmi:stats` — reports current config bloat and icon usage.
- `drush pmi:migrate` — converts all existing base64 icons to Media entities.

A typical migration run looks like:

```bash
drush pmi:stats     # see the current bloat
drush pmi:migrate   # convert base64 icons to Media entities
drush pmi:stats     # should now show ~0 MB bloat
drush cex           # export the leaner config
```

After that, commit the smaller config and enjoy the faster exports and cleaner
diffs.
