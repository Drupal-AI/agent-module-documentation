# Node Read Time — manual setup guide

**Node Read Time** (`node_read_time`) adds an estimated "reading time" to your
nodes — the familiar "5 minutes" label you see on blog posts and articles. It
counts the words in a node's text (including text pulled in from referenced
Paragraphs and blocks), divides by a reading rate you choose, and shows the
result wherever you place it.

You control three things from one simple settings page: which content types get a
reading time, how fast a reader is assumed to be (words per minute, default 225),
and how the value is formatted — whole minutes, minutes and seconds, or a bare
number. The value is **computed**, not stored, so it stays accurate automatically
as content changes; there's nothing to recalculate.

Once a content type is activated, Node Read Time gives you a `reading_time` field
you position on the node's *Manage display* page, exactly like any other field.
There's also a computed base field you can read in code and a Views field so you
can add a reading-time column to a listing. A Twig template makes the markup easy
to theme. The module has no permissions and no Drush commands, and it needs no
third-party JavaScript library.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form (which types,
   words per minute, and time format) and how to place the field.

## Where it lives in the admin menu

The settings form sits at **Configuration → Reading time**
(`/admin/config/reading-time`). Once you activate a content type there, you place
the reading-time field on that type's *Manage display* page under
*Structure → Content types → {type} → Manage display*.

## How to use it

1. Open **Configuration → Reading time** and tick the content types that should
   show a reading time. Set the words-per-minute rate and the time format. See
   [Configuration](configuration/index.md).
2. Go to that content type's **Manage display** page and drag the **Reading
   time** field out of *Disabled* into a visible region (it's hidden by default).
3. View a node of that type — the estimated reading time now appears where you
   placed the field.
