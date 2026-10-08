<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Text Summary Formatter (text_summary_formater) — agent index

A single-plugin module that adds a **"Summary only"** field formatter for `text_with_summary`
fields. It renders **only the summary**, filtered through the item's own text format, and renders
**nothing** when no summary was written. Version **8.x-1.5**, core `^10 || ^11`, depends on core `text`.

## Mechanism
- Plugin: `Drupal\text_summary_formatter\Plugin\Field\FieldFormatter\TextSummaryFormatter`
  (`@FieldFormatter` id `text_summary_formatter`, label "Summary only", `field_types = {text_with_summary}`).
- `viewElements()`: for each item with a non-empty `summary`, emits `#type => processed_text` with
  `#text` = the summary wrapped in `<div class='summary-only'>…</div>` and `#format` = the item's
  stored format (so output is `check_markup()`-filtered by the field's text format). Empty-summary
  items are skipped — **no trimmed-body fallback**, unlike core's "Summary or trimmed".
- No settings, no settings form, no config schema, no permissions, no routes, no services, no hooks.

## Name mismatch (both spellings fail in one direction)
- **Project**: `text_summary_formater` (one `t`) → `composer require drupal/text_summary_formater`.
- **Module machine name**: `text_summary_formatter` (two `t`s) → `drush en text_summary_formatter`.
- The `.info.yml` is `text_summary_formatter.info.yml`. Swapping the spellings fails each command.

## Configure
Enable, then at *Manage display* (`admin/structure/types/manage/<bundle>/display[/…]`) set the
text-with-summary field's format to **"Summary only"**. Nothing else to configure.

## When to reach for it
Core covers "Default" (full body), "Summary or trimmed" (summary or an auto-truncated body) and
"Trimmed" (always truncate). This fills the gap: show a summary **only when an editor wrote one**,
and leave the element empty otherwise so a design can respond (omit, hide the card, or fall back).

## Apply the formatter
- Install: `composer require drupal/text_summary_formater` (one `t`), then
  `drush en text_summary_formatter` (two `t`s).
- UI: at *Manage display* set the text-with-summary field's Format to "Summary only".
- Config: set the field component's `type` to `text_summary_formatter` on the relevant
  `core.entity_view_display.<entity>.<bundle>.<view_mode>` (empty `settings: {}`).
- Styling: output is wrapped in `<div class="summary-only">…</div>`.
