# Filter Empty Tags — manual setup guide

**Filter Empty Tags** (`filter_empty_tags`) is a text‑format filter that
recursively strips **empty HTML tags** from your content as it is rendered. Stray
markup like `<p></p>`, `<b></b>`, or a trailing paragraph containing only a
non‑breaking space is common in WYSIWYG output and imported content, and it can
leave odd gaps in your templates. This filter removes those empty tags so your
output stays clean — without you having to re‑edit hundreds of nodes by hand.

The module provides a single filter plugin, `filter_empty_tags`, that you enable
and order inside any text format at **Configuration → Content authoring → Text
formats and editors**. At render time it finds tags whose entire inner content is
"empty" (only whitespace, `&nbsp;`, and/or `<br>`), removes them, and then re‑runs
itself on the result — so nested structures like `<div><p><br></p></div>` collapse
fully, which a single regex pass could not do. Four settings control what counts as
empty and which tags to leave alone.

Because it is an irreversible transform filter (it changes the rendered output, not
the stored source), it should generally run **last** in a format, after other HTML
filters, so it tidies up whatever markup they produce. It has no permissions, admin
page, or Drush commands, and requires nothing outside Drupal core. There are no
submodules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There is no dedicated admin page. The filter is enabled and configured inside each
text format at **Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`).

## How to use it

1. Go to **Configuration → Content authoring → Text formats and editors** and edit
   the format you want to clean up (for example *Full HTML*).
2. Under **Enabled filters**, tick **Filter Empty Tags**.
3. Under **Filter processing order**, drag it to run **last**, after any other HTML
   filters, so it cleans up their output.
4. Adjust its settings, then click **Save configuration**.

Its settings are:

- **Tags to never remove** (`do_not_consider_empty`) — a space‑separated list of
  tag names that are kept even when empty. The default protects embeds and
  structural tags:
  `button canvas drupal-media drupal-entity iframe object script svg textarea td th`.
  Add any tag here that is legitimately empty in your content.
- **Treat whitespace‑only tags as empty** (`filter_spaces`, on by default).
- **Treat `&nbsp;`‑only tags as empty** (`filter_nbsp`, on by default).
- **Treat `<br>`‑only tags as empty** (`filter_br`, on by default).

Tags with real content are never touched — only the configured "empty" cases are
removed.
