# Renderable Options — manual setup guide

**Renderable Options** (`renderable_options`) lets the option labels in a Views
**exposed filter** carry rendered markup — icons, images, styled spans — instead
of being limited to plain text. Ordinarily a checkbox or radio filter shows a
bare string next to each option; this module makes those labels *renderable*, so
you can build richer, more visual filter widgets.

It is designed to work with the
[Better Exposed Filters](https://www.drupal.org/project/better_exposed_filters)
module, which is a hard dependency — Better Exposed Filters is what turns a
select-list exposed filter into checkboxes/radios in the first place, and
Renderable Options extends that to allow markup in each option's label. It works
best with the newer Entity Reference Views filter; note that entity-reference
filters are not defined by default, so you may need to declare a filter for your
fields via `hook_views_data_alter` (see the module's change record), or use the
Views Core Entity Reference module for standard filters.

One thing to keep in mind: the rendered labels are **admin-supplied markup**.
Because markup is output as-is, only trusted administrators should be able to set
these labels, and you should make sure the markup you enter is safe. The module
itself has no access-control role — it only affects how filter labels are
displayed.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside Better Exposed Filters.

There is **no dedicated configuration page** for this module. You turn renderable
labels on per exposed filter, from the Views UI, as described below.

## How to use it

Renderable Options adds no admin menu item of its own. You use it entirely from
the **Views UI**, on an exposed filter that is already using Better Exposed
Filters:

1. Edit the View and open the **exposed filter** you want to enrich (for example
   an entity-reference or options filter).
2. Set that filter's exposed form widget to a **Better Exposed Filters** widget
   that shows individual options — such as **Checkboxes/radio buttons**.
3. With Renderable Options enabled, the option labels can now contain rendered
   markup. Configure the markup for your options and save the View.

If your filter is an entity-reference filter, remember it is not defined by
default — declare it for your fields with `hook_views_data_alter` (per the
module's change record at drupal.org) or use the Views Core Entity Reference
module for standard filters.
