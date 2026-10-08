# Facets Short Pretty Paths — manual setup guide

**Facets Short Pretty Paths** (`facets_short_pretty_paths`) shortens the clean URLs
produced by the
[Facets Pretty Paths](https://www.drupal.org/project/facets_pretty_paths) module.
Facets Pretty Paths turns faceted‑search filters into human‑readable path segments
instead of query strings; on a page with several active facets those paths can grow
long and repetitive. This module compresses them into tidier, still‑readable URLs.

Its main trick is removing term IDs from taxonomy‑term aliases and joining multiple
values for one facet with a dot, writing the facet's alias only once. So a
three‑colour filter becomes:

```
/color/black.yellow.red
```

instead of the longer, repeated form:

```
/color/black-1/color/yellow-2/color/red-3
```

When a taxonomy term has no machine name yet, it falls back to the default coder
(term ID) so URLs stay unique. It is purely a routing/URL‑presentation feature
layered on Facets Pretty Paths — it changes the *form* of the URL, not access or the
results returned. It depends on Facets Pretty Paths, and optionally on the
[Taxonomy Machine Name](https://www.drupal.org/project/taxonomy_machine_name) module
to guarantee uniqueness within a vocabulary.

> Before installing, review the linked Facets Pretty Paths issue referenced on the
> project page — this module exists as a contributed alternative to a core patch,
> and it overrides the pretty‑paths active‑filters service.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Facets Pretty Paths.

There is **no module‑wide settings page** — you switch the URL processor and coder
on the facet source and facets, described in "How to use it" below.

## Where it lives in the admin menu

The module adds no admin page of its own. You configure it from **Configuration →
Search and metadata → Facets** (`/admin/config/search/facets`), on the facet source
and the individual facets.

## How to use it

1. Make sure Facets and **Facets Pretty Paths** are already set up and working.
2. On the **facet source**, select the **Short pretty paths** URL processor
   (provided by this module) in place of the standard pretty‑paths processor.
3. On each taxonomy‑term facet, if you use this module, select the **Taxonomy term
   machine name pretty paths coder**. Alternatively, add a field to the vocabulary
   and declare it in `settings.php`:

   ```php
   $settings['facets_short_pretty_paths_field_name'] = 'field_name';
   ```

4. Save. Faceted URLs are now emitted in the shortened form.

> **Known limitation:** term‑name uniqueness within a vocabulary relies on the
> optional Taxonomy Machine Name module. Note also the module's issue queue mention
> that machine names may need to be generated after enabling it.
