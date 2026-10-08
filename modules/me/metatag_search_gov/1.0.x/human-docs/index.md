# Metatag Search.gov — manual setup guide

**Metatag Search.gov** (`metatag_search_gov`) adds the Search.gov-specific meta
tags that the US federal [Search.gov](https://search.gov/) service uses when it
indexes and classifies your content. It plugs into the
[Metatag](https://www.drupal.org/project/metatag) module and exposes the
`searchgov_custom1`, `searchgov_custom2`, and `searchgov_custom3` fields, which
Search.gov reads to power its faceted "Search Filters".

It exists to solve a specific formatting problem: the Metatag Custom module emits
multiple separate meta tags, but Search.gov expects a single tag whose values are
comma-separated. This module provides the three custom fields in the shape
Search.gov wants. It depends on the Metatag module and is aimed squarely at
US-government sites indexed by Search.gov.

As an SEO/structured-metadata feature, it simply reflects on-page content into the
head of the document — it has no content or access-control role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Metatag dependency.
2. [Configuration](configuration/index.md) — add tokens for the three Search.gov
   custom meta tags.

## Where it lives in the admin menu

The module adds its fields to the standard Metatag configuration. After
installation, configure the three custom tags at
`/admin/config/search/metatag/node#edit-search-gov` (the **Search.gov** group on
the Metatag defaults form). See [Configuration](configuration/index.md).
