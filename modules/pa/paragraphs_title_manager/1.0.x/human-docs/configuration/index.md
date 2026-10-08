# Configuration

Paragraphs Title Manager is configured entirely from one screen, where you decide
which title fields the module manages and how each one is aligned. The settings
apply globally across all Paragraph types, so you set alignment once rather than
theme‑by‑theme or bundle‑by‑bundle.

## Open the settings form

1. Log in as a user with the **Manage Paragraphs Title Alignment** permission.
2. Go to **Configuration → Content authoring → Paragraph Title Settings**, or
   navigate directly to `/admin/config/content/paragraph-title-settings`.

## How title fields are detected

You do not add fields to this screen by hand. The module inspects every Paragraph
bundle and automatically lists any field whose **machine name contains the
substring `title`** — for example `title`, `sub_title`, `title_one`, or
`section_title`. Fields that do not match (such as `subtitle`, `heading`, or
`label`) are ignored by design. New title fields appear here automatically, with
no cache rebuild required.

If a Paragraph type has no title‑like fields, the form shows an internal notice in
that section. If no title fields are detected anywhere, the page shows a full‑page
notice explaining the naming rule fields must follow to appear.

## The form, field by field

The screen uses a grid layout that **groups fields by Paragraph bundle**. For each
detected title field you get:

- **An enable checkbox** — tick it to have the module manage alignment for that
  specific field, or leave it unchecked to leave the field alone.
- **An alignment selector** — choose the alignment applied to that field. The
  available options are drawn dynamically from the module's alignment options and
  typically include **left, center, right, justify, start, and end** (plus any
  custom options that have been added to the module's alignment options table).

## Bulk controls

To avoid setting every field one at a time, the form provides global helpers:

- **Select All / Deselect All** — a single toggle to enable or disable management
  for all listed fields at once.
- **A global alignment selector** — pick one alignment and apply it to every field
  you currently have selected, so you can align all your headings consistently in
  one action.

## Save and how it takes effect

Save the form when you are done. At render time the module adds a CSS class of the
form `ptm-title-align-{alignment}` (for example `ptm-title-align-center`) to the
paragraph's wrapper for each managed field that has a value, and exposes matching
Twig variables your theme can use:

- A wrapper‑level `paragraphs_title_manager_classes` array of classes.
- Per‑field variables such as `field_title_alignment_class` and
  `sub_title_alignment_class`.

For certain bundles (for example card layouts) a mobile‑specific override class
(`ptm-title-center-mobile`) may also be added. Your theme's CSS is responsible for
turning these classes into the actual visual alignment, but no per‑template or
per‑bundle logic is needed on your side.
