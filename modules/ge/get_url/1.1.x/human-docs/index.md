# Twig Get URL — manual setup guide

**Twig Get URL** (`get_url`) is a tiny developer helper that adds one new
function to Twig: **`get_url()`**. Give it a node's ID and it returns that node's
URL — using the path alias when one exists. It exists to solve a small but
common annoyance: sometimes in a template you only have a node ID to work with,
and turning that ID into a proper aliased link would otherwise mean a preprocess
hook or a more roundabout Twig incantation.

There is nothing to configure and nothing to click. Once the module is enabled,
the function is simply available in every Twig template on the site. It was built
for a theme's internal use and released to the community; it has no dependencies
beyond Drupal core.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it has no settings form. Its
only job is to make the `get_url()` Twig function available.

## How to use it

In any Twig template, call `get_url()` with a node's ID as its single argument:

```twig
<a href="{{ get_url(123) }}">Read more</a>
```

That returns the URL for node 123, using its path alias if one is set. You can
pass a variable holding a node ID in exactly the same way:

```twig
<a href="{{ get_url(node_id) }}">{{ title }}</a>
```

There is nothing else to set up — enable the module and the function is ready to
use across your theme's templates.
