# Votingapi Widgets — manual setup guide

**Votingapi Widgets** (`votingapi_widgets`) turns the [Voting API](https://www.drupal.org/project/votingapi)
module into a ready-to-use, field-based rating system. Instead of writing code to
collect and tally votes, you add a **Voting API field** to any entity bundle —
articles, products, comments, media, taxonomy terms — pick a widget, and your
visitors can rate content inline through an AJAX form that updates the results
without a page reload.

Three widgets ship out of the box: **five-star** (a 1–5 star rating), **like** (a
single thumbs-up), and **useful** (a thumbs up / thumbs down). Each field can show
an aggregate result — an average score, a vote count, or a "useful" tally — using
result functions that scope their maths to that one field. Formatter options let
you choose a visual style, render the result read-only (results shown, voting
disabled), or show the viewer their own cast vote instead of the average.

Voting is controlled by **per-field permissions** that the module generates
automatically. Every voting field you add creates its own set of "vote", "edit own
vote", "clear own vote", and "edit voting status" permissions, so you decide
exactly who can rate each piece of content — including whether anonymous visitors
may vote (double-voting is limited by an IP-based rollover window). The module also
**defines** the `VotingApiWidget` plugin type, so developers can build custom
widgets such as a ten-point scale.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its Voting API
   dependency with Composer, enable it, and (for five-star) drop in the required
   JavaScript library.
2. [Configuration](configuration/index.md) — add a Voting API field and walk
   through its storage, instance, widget, and formatter settings, then assign the
   per-field permissions.

## Where it lives in the admin menu

There is **no central settings page**. Everything is configured on the field
itself:

- Add the field on a bundle's **Manage fields** tab (for example
  **Structure → Content types → Article → Manage fields**).
- Choose how it is entered on the **Manage form display** tab and how results are
  shown on the **Manage display** tab.
- Grant the generated voting permissions at **People → Permissions**
  (`/admin/people/permissions`).
