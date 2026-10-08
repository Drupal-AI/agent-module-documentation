# Twig Views — manual setup guide

**Twig Views** (`twig_views`) adds a single Twig function, `render_view()`, that
renders a Views display — together with its title — directly from any Twig
template. Give it a view's machine name and a display's machine name, and the view
is loaded, rendered, and printed right where you call it, with the view's title
emitted in an `<h2>` above the results.

It's a themer's convenience. Normally, to place a listing you either configure a
block and position it in a region, or write a preprocess function. With Twig Views
you just drop `render_view('frontpage', 'page_1')` into `node--article.html.twig`,
a paragraph template, a region template, or a Layout Builder component — keeping
placement in version-controlled templates rather than block config. You can even
pass extra arguments, which become the display's contextual filter values, so the
same display can be reused with different inputs (for example the current node's
ID).

The entire module is this one function. There is no admin UI, no settings, no
permissions, and no configuration — it just needs core Views.

This guide is written for a **human** working in templates. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Nowhere — Twig Views has no admin page. It simply makes the `render_view()`
function available in every Twig template once enabled.

## How to use it

After enabling the module, call the function in any template:

```twig
{# A page or block display that has no contextual filters #}
{{ render_view('frontpage', 'page_1') }}

{# Pass the current node ID as the first contextual (argument) filter value #}
{{ render_view('related_content', 'block_1', node.id) }}

{# Multiple contextual arguments, in order #}
{{ render_view('events_by_region', 'embed_1', term.id, 'upcoming') }}
```

- **First argument** — the view's machine name (e.g. `content`, `frontpage`).
- **Second argument** — the display's machine name (e.g. `page_1`, `block_1`,
  `default`). This is **required**; omitting it, or naming a display that doesn't
  exist, throws an error.
- **Any further arguments** — passed to the display as its contextual filter
  (argument) values, in order. Displays without matching contextual filters simply
  ignore extras.

### Good to know

- The function always prepends the view's configured title inside an `<h2>`. If you
  don't want a heading, set the display's title to empty (or use core's block/area
  handlers instead).
- There is **no extra access check** beyond what the view display itself enforces —
  the view renders with the current user's access, exactly like any embedded view.
- The output is treated as safe HTML, so it's printed without additional escaping.
