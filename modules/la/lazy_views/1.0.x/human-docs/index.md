# Lazy Views — manual setup guide

**Lazy Views** (`lazy_views`) is a tiny, JavaScript-only helper that loads any
Drupal **View** on demand — either when a visitor clicks something, or
immediately after the page has painted — instead of rendering it up front. It's a
performance tool: heavy Views (related content, dashboards, reports, personalised
listings) stay off the critical rendering path, so the initial HTML is lighter and
the page appears faster.

There is nothing to configure and no admin screen. You use it entirely through
`data-lv-*` attributes on an element in your markup. Lazy Views watches for any
element carrying a `data-lv-id` attribute, reads the View name, display, target
placeholder, arguments and trigger from its attributes, and calls Drupal's own
`views/ajax` endpoint to render the View into a placeholder on the page. Because
it just calls core's Views AJAX route, the View still renders server-side with all
its normal access checks — Lazy Views only changes *when* the request is made, not
*whether* the visitor is allowed to see the results.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead. For the full list of `data-lv-*`
attributes and worked examples, the agent [`theming/markup.md`](../agent/theming/markup.md)
reference is the most complete source.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Nowhere — Lazy Views has no admin page, no permissions, and no settings. Once
enabled, its small JavaScript library is attached to every page automatically, and
it acts on any element you add the `data-lv-*` attributes to.

## How to use it

You need **two** things on the page: a **trigger element** carrying the
`data-lv-*` attributes, and a **placeholder** element for the results to land in.

Load a View on click, into a placeholder:

```html
<button data-lv-id="my_related" data-lv-display="block_1" data-lv-target="related-wrapper">
  Show related
</button>
<div class="related-wrapper"></div>
```

Lazy-load a View automatically on page load (add `data-lv-execute`), passing a
contextual argument:

```html
<div class="promo-wrapper"></div>
<span data-lv-id="promos" data-lv-display="block_1"
      data-lv-target="promo-wrapper" data-lv-args="42" data-lv-execute="1"
      style="display:none"></span>
```

The attributes you can set are:

- **`data-lv-id`** (required) — the View's machine name (for example `frontpage`).
- **`data-lv-display`** (required) — the display id (for example `page_1`,
  `block_1`). Nothing loads without it.
- **`data-lv-target`** (default `lazy-view`) — the class or id of the placeholder
  that receives the rendered View.
- **`data-lv-args`** — contextual arguments passed to the View.
- **`data-lv-execute`** — if set, the View loads immediately on page load instead
  of waiting for a click.
- **`data-lv-type`** (default `POST`) — the HTTP method for the request; set to
  `GET` if you prefer.
- **`data-lv-progress-type`** (default `fullscreen`) — the AJAX progress indicator
  (`fullscreen`, `throbber`, `bar`, `none`).

The trigger event is `click` by default, or the event you name in
`data-lv-execute`. You can wire several independent lazy Views on one page, each
with its own target and placeholder. Put the trigger and placeholder wherever
markup lives — a Twig template, a block, a field, or custom HTML.
