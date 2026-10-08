# Field Long Text Pager — manual setup guide

**Field Long Text Pager** (`field_longtext_pager`) provides a field formatter that
breaks a long text field into readable, indexed sub-pages with a pager — so a very
long article, policy, or manual can be read a page at a time instead of as one
endless scroll. You choose how it splits: at explicit page-break placeholders you
insert in the text, or automatically after a set number of characters, words, or
HTML blocks. The splitting algorithm is written to break complicated HTML markup
cleanly, so paragraphs and lists are divided without producing broken tags.

Alongside the pager it offers a few optional display extras: a **pager index**
field, an **estimated reading time** field, and **AJAX paging** so readers move
between pages without a full page reload. It is purely a content-display feature —
it paginates the *rendered* text and does not change the stored data. It provides
its own permission but has no access-control role beyond that.

The formatter is configured per field on **Manage display**, and the module also
has a small site-wide **default settings** page so you can set sensible defaults
once. Because paging relies on a page-break placeholder in your content, you'll
also want to make sure your text formats and editors allow that placeholder — there
are CKEditor plugins available for inserting page breaks by hand.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set the module defaults and enable
   the pager formatter on a field.

## Where it lives in the admin menu

The module's default-settings form sits at **Configuration → Content authoring →
Field Long Text Pager** (`/admin/config/content/field_longtext_pager`). The
per-field paging options live on each bundle's **Manage display**.
