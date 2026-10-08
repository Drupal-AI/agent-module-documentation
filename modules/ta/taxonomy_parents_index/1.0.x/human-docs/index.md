# Taxonomy Parents Index — manual setup guide

**Taxonomy Parents Index** (`taxonomy_parents_index`) is a performance module for
large taxonomies. It builds and maintains a separate index table that stores **every
ancestor Term ID** for each taxonomy term (alongside the term's own ID), so you can
look up all of a term's parents up the hierarchy instantly instead of walking the
parent chain each time.

The problem it solves is a specific, real one. Core provides a *"Has taxonomy term ID
(with depth)"* contextual filter for building views that list content tagged with a
term or any of its children. That filter gets slow as a vocabulary grows — the
maintainers saw several-second response times (and poor PageSpeed scores) on views
once they had more than 100,000 terms and nodes. This module replaces that slow
filter with a fast lookup against its pre-computed index. **Unless you are hitting
that kind of scale, you probably do not need this module yet.**

The trade-off is that the index has to be kept up to date: the module maintains its
records every time a term is created, updated, or deleted. Compared with the
alternative (indexing everything in Search API and rebuilding your term views around
it), this approach lets you keep using Drupal's default taxonomy term views, and
handles the case of multiple term-reference fields (Tags *and* Category) without extra
work. It has no module dependencies beyond core Taxonomy, and provides its own
permission gating the reindex operation. The index reflects the term hierarchy and
carries no access-control role of its own.

You do need to configure it: run an initial reindex, then adjust one View to use the
new index instead of the core filter.

This guide is written for a **human** using the admin UI. If you are an AI coding
agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — build the index, then switch a View
   over to it.

## Where it lives in the admin menu

The reindex form is at `/admin/taxonomy_term_parents_reindex` (route
`taxonomy_parents_index.reindex_form`). See [Configuration](configuration/index.md)
for how to build the index and wire it into a View.
