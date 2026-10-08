# Synfilters — manual setup guide

**Synfilters** (`synfilters`) extends the
[Better Exposed Filters](https://www.drupal.org/project/better_exposed_filters)
(BEF) module with additional exposed-filter widgets and behaviours for Views. If
you already use BEF to turn a View's exposed filters into friendlier controls —
checkboxes, radios, sliders and the like — Synfilters adds more options on top of
what BEF offers.

It is a content-display feature that affects the exposed-filter UI on Views. It
does not add any content of its own and has no access-control role: results shown
through the enhanced filters still respect the underlying View's own access
rules. It depends on the Better Exposed Filters module, belongs to the SynapseF
package, and supports Drupal 8, 9, 10 and 11. It is currently marked *not covered*
by Drupal's security advisory policy.

There is no central settings form to fill in — the extra widgets Synfilters
provides are chosen and configured **per View**, inside the exposed-filter
settings that Better Exposed Filters adds to the Views UI.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, alongside
   Better Exposed Filters, and enable the module.

## How to use it

Once enabled, edit a View with exposed filters and open its **Exposed form** /
Better Exposed Filters settings in the Views UI. The additional widgets and
behaviours Synfilters provides appear there as further choices for how each
exposed filter is rendered. Pick the widget you want for a given filter, adjust
its options, and save the View. The filters then take effect wherever that View
is displayed, always honouring the View's access.
