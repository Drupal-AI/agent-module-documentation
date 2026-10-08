# CKEditor Insert Blocks — manual setup guide

**CKEditor Insert Blocks** (`ckeditor_insert_blocks`) is a CKEditor 5 plugin
that lets an editor drop a Drupal block straight into body content from the
editor toolbar. Click the button, a menu appears, and you pick any block on the
site — a custom module block, a Views block, or a content block — and it is
inserted where your cursor sits.

The problem it solves is a familiar one: components such as a call‑to‑action, a
related‑content listing, a newsletter signup, or a promotional panel already
exist as blocks, and an editor wants one partway down an article. The structured
alternatives — a Paragraph type or Layout Builder — are better designed but a
much larger change to how the site is built. Inserting a block from the editor is
the pragmatic middle ground, and, importantly, it keeps the block a *reference*
rather than a copy: update the block and every article that embeds it updates too.

A word of caution worth reading before you enable this for your editors. A block
can render arbitrary markup and attach JavaScript libraries, so the ability to
place *any* block into body text is closer to a site‑building capability than an
ordinary editing one. A Views block runs a view inside the article with its own
access rules and filters, which means the embedded result varies by viewer — the
host content's cache metadata has to account for that. The single most important
control is **which blocks the button offers**: you can restrict the list in the
plugin's settings, and an unrestricted "all blocks on the site" list is a far
larger grant than a curated set. See [Configuration](configuration/index.md) for
how to lock that down.

The module works on Drupal 10 and 11 and has no other module dependencies. If you
want the optional server‑side filter that re‑renders embedded blocks through the
text format on Drupal 10/11, you will also need the `symfony/dom-crawler` library
(it ships with Drupal 9 core but not 10/11) — more on that in
[Installation](installation/index.md).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and add the optional DOM‑crawler library.
2. [Configuration](configuration/index.md) — add the toolbar button per text
   format, restrict which blocks it offers, and set classes/libraries and the
   filter.

## Where it lives in the admin menu

Insert Blocks has no standalone settings page of its own. You set it up per text
format at **Administration → Configuration → Content authoring → Text formats and
editors** (`/admin/config/content/formats`): edit a format that uses CKEditor 5,
drag the Insert Blocks button into the toolbar, and configure the plugin's
options there. The [Configuration](configuration/index.md) page walks through it.
