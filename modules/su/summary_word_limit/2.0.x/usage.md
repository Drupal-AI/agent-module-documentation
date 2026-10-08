<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Summary Word Limit adds a maximum word count to the summary part of a `text_with_summary` field, enforced as a validation constraint.

---

Summaries are what appear in teasers, listings and search results, and layouts assume they are short. Nothing in core enforces that. An editor who pastes three paragraphs into the summary box gets no warning, and the problem surfaces later as a broken card in a grid — usually noticed by someone other than the person who caused it.

The implementation is the correct Drupal one, and small enough to describe completely. The limit is a third-party setting on the field configuration, so it lives with the field rather than in a global settings page. Enforcement is a validation constraint (`SummaryWordLimit` plus `SummaryWordLimitValidator`), which means it applies wherever the entity is validated — the node form, but also REST, JSON:API, migrations and programmatic saves. A limit that only existed in the form would be trivially bypassed by every one of those.

Setup is per field: edit a Text (formatted, long, with summary) field, tick **Summary input** if it is not already on, and enter a number in **Summary word limit count**. Leaving it empty means no limit, so enabling the module changes nothing until a limit is set.

Two classes, no routes, no permissions, no configuration page.

---

- Limit the length of a node summary.
- Keep teaser text short enough for a card layout.
- Enforce editorial guidelines on summary length.
- Validate summary length on the node form.
- Validate summary length over REST.
- Validate summary length over JSON:API.
- Validate summary length on programmatic saves.
- Set the limit per field rather than globally.
- Enable Summary input on a body field.
- Leave the limit empty to disable it.
- Prevent broken listing layouts.
- Give editors an error instead of a silent overflow.
- Apply different limits to different content types.
- Use a validation constraint rather than form logic.
- Keep the limit with the field configuration.
- Migrate content without bypassing the limit.