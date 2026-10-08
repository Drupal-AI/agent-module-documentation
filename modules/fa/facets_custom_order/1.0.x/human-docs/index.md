# Facets Custom Order — manual setup guide

**Facets Custom Order** (`facets_custom_order`) lets you sort a facet's values into
a sequence *you* define, instead of alphabetically or by result count. Many facets
have an inherent order that neither default respects: a price band should read low
to high, a size facet should be S, M, L, XL rather than alphabetical (which puts L
first), a rating should descend, and a status should follow its workflow. Sorting
by count is worse still, because the order shifts as content changes — a visitor
who filters and comes back finds the options rearranged. A fixed, configured
sequence solves both problems.

This is especially handy for facets whose values have no natural weight to sort by,
or that come from aggregated index fields with no single source you could attach a
weight to. You define the order once, and the facet always renders in that order.

Two things are worth keeping in mind. **The order is configuration but the values
are content**, so a taxonomy term (or other value) added *after* you set the order
has no place in the sequence — decide how you want new values handled so a new size
does not silently disappear from the facet. And facet order is a real usability and
accessibility matter, not just cosmetics: an ordered list can be scanned to the
right place and stopped at, while an unordered one forces the reader to scan all of
it.

The module has **no central settings form** — the custom order is configured
directly on each facet.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Facets dependency.

There is **no configuration page** for this module — you set the custom order on
each facet, described in "How to use it" below.

## Where it lives in the admin menu

Facets Custom Order adds no admin page of its own. You configure it from the
**Facets** admin UI (**Configuration → Search and metadata → Facets**,
`/admin/config/search/facets`) when editing an individual facet.

## How to use it

1. Create or edit the facet you want to order at **Configuration → Search and
   metadata → Facets**.
2. In the facet's **processors** (the sorting/order settings), enable the custom
   order provided by this module.
3. Arrange the facet's values into the sequence you want and save.
4. Decide how newly added values should be handled, and re‑check the order after
   adding new terms so nothing important drops off the end of the list.
