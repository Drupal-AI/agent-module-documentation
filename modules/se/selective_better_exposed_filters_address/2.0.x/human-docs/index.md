# Selective BEF Address — manual setup guide

**Selective BEF Address** (`selective_better_exposed_filters_address`) adds
"selective" options to Better Exposed Filters for **Address** fields — so an
exposed filter on an Address field only offers the values (countries, regions, and
so on) that actually appear in the results, instead of listing every possible
option including ones no result uses. The effect is a cleaner exposed filter with
no dead-end choices.

It is the Address-field counterpart to the taxonomy-oriented Selective Better
Exposed Filters module. It works with the Address module's `country_code` and
`administrative_area` field values, and gives you options to restrict the exposed
filter's choices to those present in the result set — or in the already-filtered
result set — so the filter reflects the data users can actually reach. Because it
only affects which options an exposed filter presents, it has no access-control
role: the results themselves still respect the View's own access settings.

This module has no settings page of its own. You turn the selective behaviour on
per filter, within the Better Exposed Filters configuration of the View. It
depends on both the **Address** (`address`) and **Better Exposed Filters**
(`better_exposed_filters`) modules.

This guide is written for a **human** working through the admin UI. If you want
terse references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

In the Views UI, edit the View with an exposed Address filter. Open the exposed
filter's settings and, under the Better Exposed Filters configuration, choose the
new selective option this module adds — restricting the offered values to those in
the result set (or the already-filtered result set). Save the View, and the
exposed filter will now list only address values that appear in the results.
