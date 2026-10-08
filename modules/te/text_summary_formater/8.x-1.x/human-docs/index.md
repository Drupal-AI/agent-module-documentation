# Text Summary Formatter — manual setup guide

**Text Summary Formatter** (project `text_summary_formater`) adds a "Summary
Only" display formatter for text-with-summary fields. It shows the summary part
of the field and nothing else — and, importantly, renders nothing at all when no
summary was written.

Core's text-with-summary field ships three formatters, and none of them does
quite this. "Default" shows the full body, "Summary or trimmed" shows the
summary but falls back to a trimmed slice of the body when there is none, and
"Trimmed" always trims. The gap is the case where you want a summary to appear
*only when an editor deliberately wrote one* — a homepage promo, a card in a
listing, a related-items panel. An automatic trim of the first couple of hundred
characters of body text tends to cut off mid-sentence, which reads as neglect.
This formatter makes the presence of a summary the editorial signal: if a
summary was written it appears, and if it was not the element is simply empty and
your design can respond to that.

The module is tiny — just the formatter, a config schema and tests — and depends
only on core's **Text** module. It runs on Drupal 10 and 11.

One design consequence is worth settling up front: a card that renders nothing
where a summary was expected needs a layout that tolerates the gap. Decide
whether an empty summary should mean an omitted element, a hidden card, or some
other deliberately chosen fallback, rather than leaving it to chance.

**Heads-up on the name — this trips people up.** The drupal.org **project** name
is misspelled with one `t`: `text_summary_formater`. The **module it actually
ships** is spelled correctly, `text_summary_formatter` (two `t`s). So the Composer
package uses the one-`t` spelling and the Drush enable uses the two-`t` spelling
— mixing them up makes either command fail. The exact commands are in
[Installation](installation/index.md).

This guide is written for a **human** setting the module up through the admin
UI. If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (mind the spelling).

## How to use it

The module surfaces as a display option on any text-with-summary field:

1. Go to the **Manage display** screen for the content type whose
   text-with-summary field (for example the article **Body**) you want to change.
2. Set that field's formatter to **Summary Only** and save.

The field now renders only the editor-written summary, and stays empty when no
summary was entered.
