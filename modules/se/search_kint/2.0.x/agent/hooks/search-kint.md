<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mechanism — how Search kint hooks in and what it operates on

Search kint is **entirely front-end**. It has no PHP beyond one hook, no routes,
services, permissions or config. Its whole job is to attach a JS/CSS library that
enhances the HTML that **Devel's Kint** already rendered into the page. It never
produces a dump itself — a dump only exists on a page because a developer called
`kint()` / `dump()` / `ksm()` (Devel + `kint-php/kint`).

## The one hook

`search_kint_page_attachments(array &$attachments)` — `search_kint.module:11`.
Implements `hook_page_attachments()` and **unconditionally** attaches the
`search_kint/search_kint` library to every page for every user:

```php
$attachments['#attached']['library'][] = 'search_kint/search_kint';
```

There is a `@todo` in the source noting it should only attach when Kint is
actually invoked; as shipped, the assets load on every request but the JS is inert
unless a Kint dump is present in the DOM (see below).

## The library

`search_kint.libraries.yml` defines library `search_kint`:
- JS: `search_kint.search.js`, `search_kint.trail.js`
- CSS (theme group): `search_kint.css`
- Dependencies: `core/jquery`, `core/once`

## What the JS does (the DOM contract)

Both behaviors key off the markup Kint emits — this is the contract that must hold
for anything to happen:

- **Kint rich dumps** are `.kint-rich` containers; each tree row is a `dt`/`dd`
  pair inside nested `dl`s; the visible label is a `dfn`, the type is a `var`.
- **`Drupal.behaviors.searchKintSearch`** (`search_kint.search.js`): if at least
  one `.kint-rich` exists, it injects a small search form (`#search-kint`) before
  the first dump — plus a per-dump `<select>` when there is more than one. On
  submit it finds `dt:contains(query)` rows, marks each hit's parent with class
  `kint-query-result` (styled by the CSS), adds `kint-show` to the ancestor rows
  so the tree **expands to reveal** each match, and prints a
  `Drupal.formatPlural` count. It highlights and reveals matches; it does not hide
  non-matching rows.
- **`Drupal.behaviors.searchKintTrail`** (`search_kint.trail.js`): appends a
  "Get path" link to each `.kint dt` (using `core/once`). Clicking it walks up the
  nested `dl`s (`buildPath`) and builds a copy-paste path into a text input:
  - array segments become `$var[key]`, object segments become `$var->prop`
    (chosen from each level's `var` type text);
  - when the item sits inside a Kint **report table** (`.kint-report`, i.e. a
    field on a loaded entity), it instead emits the getter form
    `$var->get('field_name')->value`.

  This trail/path feature is the module's most valuable half: it tells you how to
  *reach* the value in code, not merely that the key exists.

## Practical notes for an agent

- Nothing renders unless a Kint dump is on the page — enable Devel and place a
  `kint($var)` call, then reload.
- `$var` in the generated path is a placeholder for whatever variable you dumped;
  substitute your real variable name.
- Development-only: Devel (and thus this) must not run in production.
