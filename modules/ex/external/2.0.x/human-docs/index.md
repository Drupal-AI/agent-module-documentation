# External Links — manual setup guide

**External Links** (`external`) opens links that point off your site — to other
websites, or to PDF documents — in a **new tab**.
It's deliberately lean: it does this one thing, and it uses JavaScript
(jQuery) rather than writing `target="_blank"` into your markup, so the page's HTML
still validates. You can also configure which pages the behaviour applies to.

Before you enable it, it's worth putting the case *against* "open in new tab" to
whoever asked for it, because it's one of the most requested and least examined
behaviours on any site:

- **It takes the back button away.** The browser's most-used control does nothing
  in a fresh tab, and a visitor who expected to return has to first notice the tab
  changed.
- **It's a change of context that must be announced.** This is a WCAG concern, not
  a matter of taste — a screen-reader user who isn't told a new window opened has
  simply lost the page. An icon alone isn't enough; the announcement needs to be in
  the link's accessible name.
- **It removes the choice from the person best placed to make it.** Anyone who
  wants a new tab can middle-click or ctrl-click; nobody can undo the reverse.

The genuine case for it is narrow — a part-completed form, a part-watched video, a
long document being read. If you do use it, pair it with a **visible and
announced** indication that the link opens elsewhere — this module adds neither an
icon nor an announcement, so that cue has to come from your theme or content.

> **Version note:** this is release **2.0.0-alpha5**, an **alpha**. Treat it
> accordingly.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form, including which
   pages the behaviour applies to.

## Where it lives in the admin menu

Its settings form is at **Configuration → Content authoring → External Links**
(`/admin/config/content/external`). The `administer external` permission that guards
it is correctly marked as a restricted-access permission, so grant it only to
trusted roles.
