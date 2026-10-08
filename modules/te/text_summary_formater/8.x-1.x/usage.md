<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Text Summary Formatter adds a "Summary only" field formatter that renders just the summary part of a text-with-summary field, and nothing when the summary is empty.

---

The module ships one plugin, `Drupal\text_summary_formatter\Plugin\Field\FieldFormatter\TextSummaryFormatter` (`@FieldFormatter` id `text_summary_formatter`, label "Summary only"), applicable only to `text_with_summary` field types (core's Body field being the canonical case). `viewElements()` iterates the field items and, for each one whose `summary` is non-empty, emits a `#type => processed_text` render element whose `#text` is the summary wrapped in `<div class='summary-only'>…</div>` and whose `#format` is the item's own stored text format — so the summary is run through `check_markup()` with its assigned format and filtered exactly like any other body output. Items with an empty `summary` are skipped entirely (`continue`), so the formatter produces **no output at all** rather than falling back to a trimmed body — this is the deliberate difference from core's "Summary or trimmed" formatter, which manufactures a truncated excerpt when no summary was written. The plugin has no configurable settings, no settings form, no config schema, no permissions and no routes; it is pure display and is governed entirely by core's field-formatter and text-format access. Two spelling caveats matter operationally: the **project** is `text_summary_formater` (one `t`) while the **module machine name** is `text_summary_formatter` (two `t`s), so `composer require drupal/text_summary_formater` and `drush en text_summary_formatter` are the correct commands — mixing the spellings fails. Enable it, then at Manage display for the entity/view mode select "Summary only" for the text-with-summary field. Requires core `text`; supports Drupal `^10 || ^11`.

---

- Show only editor-written summaries, never an auto-generated excerpt.
- Avoid mid-sentence trimmed body text on teasers.
- Render a card's promo text from the summary field.
- Show a summary on a listing or index page.
- Leave a teaser empty when no summary was written.
- Make the presence of a summary an editorial signal the design can respond to.
- Improve homepage card quality by suppressing awkward truncation.
- Display a curated abstract on a publication or article.
- Render a related-items panel using summaries.
- Support a design that hides cards with no summary.
- Show a summary in a search result row.
- Present a deliberate, hand-written excerpt in an RSS feed item.
- Support an editorial excerpt / abstract workflow.
- Show a short summary in a tooltip or hover card.
- Drive a "featured content" block from summaries only.
- Provide a clean summary-only view mode for a Body field.
- Keep a newsletter block free of truncated sentences.
- Render summaries in a Views field display via the entity's Manage display.
- Show a promo blurb on a landing page section.
- Give a taxonomy-term or user Body field a summary-only display.
- Ensure list pages stay compact by rendering only concise summaries.
- Fall through to an empty region so a fallback template can take over.
