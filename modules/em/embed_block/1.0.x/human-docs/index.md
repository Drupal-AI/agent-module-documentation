# Embed Block — manual setup guide

**Embed Block** (`embed_block`) lets editors drop a Drupal block right into body
text using a simple placeholder. Write `{block:plugin_id}` somewhere in your
content and a text filter replaces it, at render time, with the fully rendered
block — access-checked against whoever is viewing the page. It is a lightweight
way to position a block precisely inside prose without reaching for Layout Builder
or a custom CKEditor plugin.

The whole module is a single text filter. When it processes text it scans for
`{block:...}` placeholders, loads each named block plugin, checks whether the
current viewer is allowed to see it, renders it, and swaps the markup in for the
placeholder. If the same block appears twice on a page it is rendered once and
placed everywhere.

Three behaviours are deliberate and worth knowing: a block the viewer is **not**
allowed to see is replaced with nothing (an empty string, not a visible
placeholder); an **unknown** plugin id leaves the placeholder untouched in the
text, which helps you spot a typo; and because it is an ordinary text filter, you
turn it on per text format — which is also how you control who can use it.

This is an early release (`8.x-1.0-alpha4`), so test it before relying on it in
production.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and switch the filter on for a text format.

## Where it lives in the admin menu

Embed Block has no settings page of its own. You enable it as a filter on a text
format at **Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`). Which formats have the filter enabled — and who
can write in those formats — is the whole of the module's access control.

## How to use it

1. Enable the **Embed Block** filter on the text format(s) you want it to work in
   (see [Installation](installation/index.md)).
2. Find the plugin id of the block you want to embed. Block plugin ids look like
   `system_powered_by_block`, `views_block:my_view-block_1`, a custom block id,
   and so on.
3. In content using that text format, type the placeholder where you want the
   block to appear:

   ```text
   Here is some intro text.

   {block:system_powered_by_block}

   And the article continues.
   ```

4. Save and view the page. The placeholder is replaced with the rendered block —
   or with nothing, if the viewer is not allowed to see that block.

A few practical tips:

- **Keep one placeholder per line.** The matching pattern is greedy, so two
  placeholders on the same line can be mis-read as one.
- **Blocks render with their default settings** — the placeholder passes no
  configuration, so configurable blocks appear with their defaults.
- **Choose which formats get the filter carefully.** Anyone who can write in a
  format that has the filter enabled can embed *any* block plugin; the only guard
  is the per-viewer access check when the block is rendered.
