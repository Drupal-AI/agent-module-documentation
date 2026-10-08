# Exclude Frontpage Node Views filter — manual setup guide

**Exclude Frontpage Node Views filter** (`views_filter_not_front`) adds a
one-click Views filter — and a matching Search API processor — that removes your
site's front-page node from results. It solves a small but persistent annoyance:
the front page is usually a node, and that node habitually shows up again in every
"latest content" listing, A–Z index and search page, cluttering results with the
page the visitor is already on.

The clever part is that it works no matter *how* your front page is configured.
The module resolves the current front-page node by taking the path set in **Basic
site settings** and running it through Drupal's router — so it works whether that
setting is `/node/1`, a path alias, or any path that resolves to a node. If the
front page changes, or differs between environments, the filter keeps up without
you editing anything.

There are three small pieces: a service that works out which node is the front
page, a **Views filter** that excludes it from a view's query, and a **Search API
processor** that does the same for indexed search. There is nothing to configure
beyond adding the filter or enabling the processor — no settings page, no
permissions.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

The module adds no pages of its own. Its features appear where you would expect:

- The **Exclude frontpage node** filter appears in the **Views** UI (Structure →
  Views) when you add a filter to a view.
- The **Exclude front page node** processor appears in the settings of a **Search
  API** index (Configuration → Search and metadata → Search API).

## How to use it

**In a view:**

1. Edit the view and, in the **Filter criteria** section, click **Add**.
2. Search for and add **Exclude frontpage node**.
3. Save the view. The front-page node is now excluded from the results.

Note the filter cannot be *exposed* to visitors — there is nothing for a visitor
to choose, so it is simply either applied or not.

**In a Search API index:**

1. Edit the index at **Configuration → Search and metadata → Search API**.
2. On the **Processors** tab, enable **Exclude front page node**.
3. Save, and reindex if prompted.

Good to know: if your front page is **not** a node (for example a view or a custom
route), the module finds no node to exclude and the filter simply does nothing —
it degrades to a no-op rather than erroring.
