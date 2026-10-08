<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EPT Webform (ept_webform) — agent index

Config-only paragraph type that embeds a **selected webform** into a page's flow, carrying the
EPT family's shared presentation settings. Requires `ept_core`, `paragraphs`, `webform` (`^6.0`).
Version **2.0.1**. Core requirement `^10.1 || ^11 || ^12`. Ships **no PHP** (no `src/`).

## What it installs

- Paragraph type **`ept_webform`** ("EPT Webform").
- **`field_ept_webform_form`** — a **`webform` entity-reference** field, **required**, cardinality 1.
  Widget: `webform_entity_reference_select`. Formatter: `webform_entity_reference_entity_view`
  with `source_entity: true`, `lazy: false`.
- Standard EPT fields from `ept_core`: `field_ept_title` (text), `field_ept_text` (text),
  `field_ept_settings` (the `ept_settings` design-options field).
- Template `paragraph--ept-webform--default.html.twig` (prints title, the without()-ed content,
  and `{{ styles|raw }}`).

## Mechanism

1. Editor picks a webform in `field_ept_webform_form`; Webform renders it via its own
   entity-reference formatter, so **access, validation and submission handling stay in Webform**.
2. `field_ept_settings` design-options are turned into an inline `<style>` block by **ept_core's
   `GenerateCSS`** service (invoked in `ept_core_preprocess_paragraph`, output assigned to the
   `styles` variable) and printed via `{{ styles|raw }}`. Per-paragraph CSS is scoped by a
   `paragraph-id-<id>` class.

## Four established ways to put a form in a page — this is the paragraph-shaped one

- **webform reference field** — which form is stored **per node**. Right when the choice is
  editorial and the form belongs to the content.
- **block with a condition** — right when the form belongs to a **section**.
- **extra field** — attached to **every node of a type** through the display. Right when the form
  is part of what the content type **is**.
- **paragraph (this)** — in the page's **flow**, right when the form is one component among several
  and **its position matters**: hero, text, form, testimonials.

## Two things to plan

1. **A form changes the page's caching.** It carries a build id and CSRF token, so the page cannot be
   served from the anonymous page cache the same way — a real change on a high-traffic landing page.
2. **The submission's source is the paragraph.** `source_entity: true` records the referencing
   entity; confirm it resolves to the entity you want to attribute submissions to (the paragraph,
   not necessarily the host node).

## Details

- `agent/paragraphs/webform-paragraph.md` — the paragraph type, its fields, render path, and how the
  shared EPT design settings become markup.

## Related

- **EPT Webform Popup** (`ept_webform_popup`) — button that opens the webform in a popup instead of inline.
- **ept_core** — provides `field_ept_settings`, the settings widget/formatter, and `GenerateCSS`/`GenerateJS`.
