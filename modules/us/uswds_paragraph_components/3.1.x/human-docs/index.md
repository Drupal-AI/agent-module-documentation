# USWDS Paragraph Components — manual setup guide

**USWDS Paragraph Components** (`uswds_paragraph_components`) is a suite of
ready-made Paragraphs bundles that render as components from the
[U.S. Web Design System](https://designsystem.digital.gov/) (USWDS) — accordions,
alerts, cards, grid columns, modals, process lists, step indicators and summary
boxes. Instead of building these paragraph types, fields and templates by hand, a
US-government site builder can enable the components they need and let editors drop
USWDS-styled, accessible content into any entity through a Paragraphs field.

It is an **umbrella project**: the base module itself ships **no** paragraph
bundles. Every component lives in its own submodule
(`uswds_paragraph_components_accordions`, `_alerts`, `_cards`, `_columns`,
`_modal`, `_process_list`, `_step_indicator`, `_summary_box`, plus a
`_breakpoints` grid helper), so you enable only the pieces you want. Each submodule
installs its paragraph type(s), fields, entity displays and a Twig template that
emits the exact USWDS markup (`usa-accordion`, `usa-alert`, `usa-card`, and so on).
The base module provides a shared base template, a help page, and a specialised
Paragraphs field widget that pre-seeds breakpoint rows for the grid-aware
components.

Setup is entirely through configuration and the UI — there is no admin settings
page and no permissions of its own; access is governed by core Paragraphs and
field permissions. Two important points: the grid components (**Cards** and
**Columns**) automatically require the **Breakpoints** helper submodule, and the
rendered markup assumes the full USWDS CSS/JS is loaded by your **theme** (the
recommended one is [`uswds_base`](https://www.drupal.org/project/uswds_base)). The
module ships only thin per-component CSS shims, not the whole framework.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   component submodules you need.

## Where it lives in the admin menu

There is no dedicated settings page. You work in the standard field and display
places:

- **Manage fields** on a content type, to add a Paragraphs field.
- The field's settings, to allow the USWDS bundles.
- **Manage form display** of that field, to pick the USWDS Breakpoints widget.

> The README mentions a "Reset bundles" tool at
> `/admin/config/content/uswds_paragraph_components`, but it is documented as
> currently broken and has no route in 3.1.x — treat it as absent.

## How to use it

1. **Enable the components you want.** Each submodule installs its own bundle(s)
   and template. For example, to turn on the common set:

   ```bash
   drush en uswds_paragraph_components_accordions uswds_paragraph_components_alerts \
     uswds_paragraph_components_cards uswds_paragraph_components_columns \
     uswds_paragraph_components_modal uswds_paragraph_components_process_list \
     uswds_paragraph_components_step_indicator uswds_paragraph_components_summary_box -y
   ```

   Cards and Columns auto-require `uswds_paragraph_components_breakpoints`.

2. **Add a Paragraphs field** to a content type: *Manage fields → Add field →
   Reference revisions → Paragraphs*. Set the cardinality to unlimited so editors
   can stack multiple components.

3. **Allow the top-level bundles only** on the field settings:
   `uswds_accordion`, `uswds_alert`, `uswds_card_group_regular`,
   `uswds_card_group_flag`, `uswds_2_columns`, `uswds_3_columns`, `uswds_modal`,
   `uswds_process_list`, `uswds_step_indicator_list`, `uswds_summary_box`. Do
   **not** allow the sub-bundles used inside these (accordion sections, individual
   cards, process items, breakpoint rows, and so on) — they do nothing on their
   own.

4. **Pick the USWDS widget (recommended for grids).** On *Manage form display* of
   the field, choose the **"Extended Paragraphs (stable) — USWDS Breakpoints"**
   widget. It pre-fills one breakpoint row per configured breakpoint term for grid
   components, and adds a **"Disable Breakpoints field"** option that renders those
   inner breakpoint widgets read-only.

5. **Make sure your theme loads USWDS.** The templates emit raw USWDS class names;
   the actual styling must come from your theme (e.g. `uswds_base`).

To restyle any component, copy its `paragraph--uswds-*.html.twig` template from the
submodule into your theme and edit it — this is a standard Drupal template
override.
