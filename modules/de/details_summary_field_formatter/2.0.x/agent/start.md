<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# details_summary_field_formatter — agent orientation

Field formatter rendering text fields inside `<details>/<summary>`. Field types: text, text_long, text_with_summary.

- Class: `src/Plugin/Field/FieldFormatter/DetailsSummaryFormatter.php`.
- Content via `#type => processed_text` (respects text format) + custom summary via `Xss::filterAdmin()` → no XSS surface. Sound.
- No routes/perms/DB/external calls.
