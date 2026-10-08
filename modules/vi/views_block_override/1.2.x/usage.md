<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Block Override adds a "Block with overrides" Views display that lets each placed block instance override the view's contextual filters, exposed sort, pager ID, and more-link — configured right in the block settings form instead of being fixed on the view.

---

The module provides a single Views display plugin, `views_block_override`, subclassing core's `Block` display. It adds an extended "Allow" option set — on top of core's "Items per page" it offers `contextual_filter`, `exposed_sort`, `pager_id`, `more_link_text`, and `more_link_custom_url`, each toggled in the display's *Block settings → Allow settings*. Whatever you allow becomes editable per block instance in the block configuration form (`blockForm()`): contextual filters render as text fields (or entity autocomplete / radios / checkboxes when the argument has an `entity:*` validator), exposed sort renders as order + direction selects built from the view's sort handlers, pager ID as a number field, and the more-link as text fields. On submit (`blockSubmit()`) these are stored in the block's own configuration. At render time `preBlockBuild()` applies the sort and pager-ID overrides to the display, and `execute()` injects the contextual-filter values as view arguments (multiple values joined with `+`) and sets the custom more-link URL/text. This makes one view reusable across many blocks with different arguments/sorting — especially powerful with Layout Builder, Paragraphs, and the Block Field module. It depends only on core Views and adds no permissions, routes, or Drush commands; it ships a Views display schema.

---

- Reuse one view as several blocks, each passing a different contextual filter value.
- Let a content editor set a view block's contextual argument from the block config form (no new view display).
- Provide an entity autocomplete for a contextual argument that validates against an entity type.
- Offer radios/checkboxes for a contextual argument validating against a *bundle* entity type.
- Pass multiple contextual filter values from one block (joined with `+` for OR-style arguments).
- Let editors choose the exposed sort field per block instance.
- Let editors choose ascending/descending sort direction per block.
- Override the pager ID for a block to avoid pager collisions when multiple views paginate on one page.
- Set a custom "more" link text per block.
- Set a custom "more" link URL per block.
- Combine with Layout Builder to place the same view multiple times with different arguments.
- Combine with Paragraphs + Block Field so authors embed a configurable view block inside content.
- Build a "related content" block whose taxonomy/term argument is chosen per placement.
- Show the same listing filtered by different categories in different regions.
- Give site builders per-block control without cloning views or duplicating displays.
- Keep a single source-of-truth view while varying presentation by block.
- Drive a contextual filter by an entity reference selected via autocomplete in the block form.
- Restrict which overrides are exposed by toggling only the needed "Allow" options.
- Replace the fixed items-per-page with per-block values (inherited from core Block display).
