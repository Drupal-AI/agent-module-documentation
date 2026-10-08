# Computed Breadcrumbs — manual setup guide

**Computed Breadcrumbs** (`computed_breadcrumbs`) adds a computed property to
nodes that returns the list of their breadcrumb links, so a node's breadcrumb
trail can be read like any other field. It works cleanly with **JSON:API**, which
is the whole point: Drupal normally builds breadcrumbs during *rendering*, so a
decoupled front end fetching a node over JSON:API gets the node's fields but no
breadcrumb — because the breadcrumb was never a property of the node, only a
property of rendering it. Making it a computed field moves it into the data, where
a front end, a View, or a search index can read it alongside `title` and `body`.

The module works as soon as you enable it — there is no settings form, no
dependencies beyond core, and it works on Drupal 10 and 11. In code you read the
value like any other field:

```php
$breadcrumbs = $node->get('breadcrumbs')->getValue();
```

Two things are worth knowing before you rely on it. **Computed fields are
computed per request**, so a listing of fifty nodes computes fifty breadcrumb
trails — check the cost before putting the field on a high-volume API response.
And **breadcrumbs are context-dependent** in core: the same node reached through
two different paths can legitimately have two different trails, and a computed
field has to pick one. Know which trail it picks before relying on it for
navigation rather than for SEO markup.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — enabling it adds the
`breadcrumbs` computed property to nodes automatically.

## Where it lives in the admin menu

Computed Breadcrumbs adds no admin page. Once enabled, nodes expose a
`breadcrumbs` computed property that you consume programmatically or over
JSON:API, output in a View, or store in a search index — there is nothing to
click to configure.
