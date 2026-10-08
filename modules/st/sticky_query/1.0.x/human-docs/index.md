# Sticky Query — manual setup guide

**Sticky Query** (`sticky_query`) is a developer-oriented utility that keeps chosen
URL query strings "sticky" — that is, persistent as a visitor moves from link to
link across your site. Query parameters such as campaign tags, tracking codes, or
active filters are normally dropped the moment someone clicks an internal link;
Sticky Query rewrites outbound links so the parameters you care about are carried
along instead of being lost.

Under the hood it uses a DOM processor to rewrite the links in rendered pages,
which is why it depends on the **DOM Processor** (`domprocessor`) module. It has no
content model, no blocks, and no access role of its own — it is an API and
behaviour layer aimed at developers who need query-string state to survive
navigation. It supports Drupal 9, 10, and 11.

This is a building block rather than a click-and-go feature: there is no admin
settings screen to fill in. You decide which parameters should be sticky in code,
using the API the module provides, and the module handles rewriting links
accordingly.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent — including the API surface — read
the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its
   `domprocessor` dependency with Composer, then enable it.

## How to use it

Because Sticky Query is an API, the useful work happens in code: you tell it which
query parameters to keep, and it rewrites links (via the DOM processor) so those
parameters persist as users navigate. There is no configuration form to visit —
once the module and its dependency are enabled, wire up the parameters you want to
persist using the module's API. See the [`agent/`](../agent/start.md) docs for the
developer-facing details.
