# Prepopulate — manual setup guide

**Prepopulate** (`prepopulate`) lets you fill in a Drupal form from the URL. Add
a specially formatted query string to a link, and the form opens with those
fields already filled in. For example, the link
`/node/add/article?edit[title][widget][0][value]=Hello` opens the "create
article" form with the title box already containing *Hello*. It is the classic
way to build "add content, pre-filled" links, bookmarklets, and deep links from
marketing emails or dashboards.

The module is intentionally tiny and has **no settings screen, no permissions,
and nothing to configure**. Enabling it *is* the setup. From then on, any link
that carries an `edit[...]` query parameter will prefill the matching form
fields. It works for anonymous and logged-in users alike, with no custom code.

Behind the scenes it inspects every form, and when the request carries an `edit`
query parameter it copies those values onto the matching form elements. It only
fills a fixed, safe list of element types — text fields, textareas, formatted
text, selects, numbers, email/URL/tel, dates, machine names, entity-reference
autocompletes, and a few others. Crucially, **radio buttons and checkboxes are
deliberately left out**, so a crafted link handed to an administrator cannot
silently tick a permission or setting. Values are escaped, fields that already
have a value are never overwritten, and hidden (`#access: FALSE`) elements are
skipped. One optional submodule, **OG Prepopulate** (`og_prepopulate`), reuses
the same mechanism for Organic Groups audience fields (it requires the
`og` module).

This guide is written for a **human** building prefill links. If you want terse,
token-cheap references for an AI coding agent — the exact whitelist, the
`prepopulate.populator` service signature, and the alter hook — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (there is no configuration step).

## Where it lives in the admin menu

Nowhere — that is by design. Prepopulate has no admin page, no settings form, and
no permission of its own. Once it is enabled, its entire "interface" is the URL
syntax you write into your links.

## How to use it

You "configure" Prepopulate by writing the right query string. The rule is that
the query string mirrors the form field's internal structure, rooted at `edit`:

```
?edit[<field name>][widget][0][value]=<value>
```

A few common patterns for node and entity forms:

| What you want to fill | Query parameter |
|---|---|
| Node title | `edit[title][widget][0][value]=My title` |
| Body text | `edit[body][widget][0][value]=Hello world` |
| Any single-value text field | `edit[field_foo][widget][0][value]=…` |
| Entity reference (autocomplete) | `edit[field_ref][widget][0][target_id]=123` |
| A list field shown as a drop-down | `edit[field_list][widget]=key` |
| A datetime field | `edit[field_when][widget][0][value][date]=2026-01-31` |

Chain several fields together with `&`:

```
/node/add/article?edit[title][widget][0][value]=Hello&edit[field_tags][widget][0][target_id]=7
```

Percent-encode anything unsafe (a space becomes `%20`, `&` becomes `%26`). If a
field will not fill, the quickest way to find its exact path is to open the form,
view the page source, and read the input's `name="…"` attribute — then prefix the
field name with `edit[` and insert `[widget]` after it. If it still will not
fill, the element type probably is not on the safe list; a developer can widen
that list with the `hook_prepopulate_whitelist_alter()` hook (see the
[`agent/`](../agent/start.md) docs). A handy trick is to turn one of these URLs
into a menu link (an "internal:" link), giving editors a permanent "Add a
pre-filled X" button.
