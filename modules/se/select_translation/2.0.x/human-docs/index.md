# Select Translation — manual setup guide

**Select Translation** (`select_translation`) solves a common annoyance on
multilingual Drupal sites: when a node has been translated into several
languages, a plain Views listing tends to show that node once per translation,
so the same article appears two or three times in a row. This module adds a
single **Views filter** that collapses each node down to one best-matching
translation, so every node shows up exactly once in the reader's preferred
language.

You choose *how* the "best" translation is picked. The filter offers a few
selection modes: use the visitor's current interface language and fall back to
the node's original language; walk current → site default → original; use
Drupal core's own language-fallback chain; or supply your own comma-separated
priority list of language codes (for example `en,fr,current,default,original`).
In a custom list the special tokens `current`, `default` and `original` stand
for the current interface language, the site default language, and the node's
original untranslated language — and `original` is always tried last so a node
is never dropped from the list entirely.

Two extra checkboxes fine-tune the behaviour: show only default-language
content when the visitor is already browsing in the site default language, and
fall back to the default-language node when a current-language translation
exists but is still unpublished. The same selection logic is also available to
developers as a PHP function (`select_translation_of_node()`) and a Drush
command, so you can resolve "which translation would this mode pick?" from code
or the command line.

There is **no settings page** for this module — all of its configuration lives
inside the filter instance on each individual view. Enable the module, then add
and configure the filter wherever you build a node listing.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Select Translation adds no admin pages and no menu items of its own. You use it
entirely from inside the Views UI at **Structure → Views**
(`/admin/structure/views`): edit any view of content, then add the filter as
described below.

## How to use it

1. Make sure your site has more than one language enabled and content
   translation configured — the filter only makes sense on translated content.
2. Go to **Structure → Views** and edit (or create) a view whose base table is
   **Content**.
3. Under **Filter criteria**, click **Add** and search for **Select
   translation** (plugin `select_translation_filter`). Add it to the view.
4. In the filter settings, pick a **selection mode**:
   - Current interface language, falling back to the node's original language.
   - Current language, then the site default, then the original.
   - Drupal core's language fallback candidate chain.
   - A **custom** comma-separated priority list of language codes, where
     `current`, `default` and `original` are resolved as described above.
5. Optionally tick **show only default-language content** (applied when the
   current language equals the site default) and/or **fall back to the
   default-language node when the current-language translation is unpublished**.
6. Save the view. Each node now appears once, in the language your mode
   resolves to, with graceful fallback so nothing disappears.

Because the filter is built with LEFT JOINs against wrapped sub-queries (rather
than correlated sub-queries), it stays fast on large node tables and keeps
working under node-access modules such as Domain Access.
