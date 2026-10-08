# Rate — manual setup guide

**Rate** (`rate`) adds flexible voting widgets to your content. Once enabled it
lets you build one or more rating widgets — fivestar, thumbs up/down, yes/no,
emotion reactions, a number up/down counter, or a fully custom set of buttons —
and attach each one to the node and comment types you choose. Visitors vote with
a single AJAX click (no page reload), and every vote is stored and totalled
through the **VotingAPI** module, which Rate builds on.

The problem it solves is that Drupal core has no built-in way to let people rate
or react to content. Rate gives you a configurable, reusable widget system for
exactly that: a "was this helpful?" thumbs pair on documentation, a five-star
score on articles, a like button on blog posts, or emotion reactions on comments
— all managed from one admin screen without writing code.

Enabling the module does **not** put any widget on your site by itself. Rate
works by *configuration*: you create a **Rate widget** (a `rate_widget` config
entity) at **Structure → Rate widgets**, choose its style and which content types
it attaches to, and then grant the per-bundle voting permission it generates —
until you do that last step, nobody can actually vote. Rate depends on `votingapi`,
`node`, `views`, and `datetime` (Drupal enables these for you), and it optionally
integrates with the Charts module to draw graphs on the results tab. It ships no
submodules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module and its dependencies.
2. [Configuration](configuration/index.md) — build a widget, attach it to content
   types, set the global bot‑detection options, and grant voting permissions.

## Where it lives in the admin menu

- **Widgets** are managed at **Structure → Rate widgets**
  (`/admin/structure/rate_widgets`); add a new one at `/admin/structure/rate/add`.
- **Global settings** (bot detection, logging) live under **Configuration →
  Search and metadata → VotingAPI → Rate**
  (`/admin/config/search/votingapi/rate`).
- Each node with a widget gains a **Rate Voting results** tab at
  `/node/{node}/node-rating` for people holding the *view rate results page*
  permission.

## How to use it

After enabling Rate, the typical flow is: create a widget, pick its template
(e.g. fivestar) and value type, list the content types it should appear on, save
it, then go to **People → Permissions** and grant the generated *cast rate vote
on node of article* (etc.) permission to the roles that are allowed to vote. The
widget then renders on those content items automatically. You can show the same
widget on several content types, put several widgets on one type, display a
widget read‑only in a listing, or drop one into a View using the "Rate widget"
Views field. See [Configuration](configuration/index.md) for the step‑by‑step
detail.
