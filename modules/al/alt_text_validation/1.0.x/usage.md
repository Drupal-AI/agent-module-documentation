<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Alt-Text Validation helps editors write good image alt text by validating it against configurable rules on save and by auditing all alt text across the site into a downloadable report.

---

The module has two halves. **Validation:** `hook_entity_bundle_field_info_alter()` attaches an `AltTextRules` constraint to every field type that can carry alt text (image fields and text/formatted fields that may contain `<img>` tags). On save, `AltTextRulesConstraintValidator` runs each enabled rule; "prevent" rules block the save with an error, "warn" rules add a warning message but allow saving, and a master switch (`alt_text_validation_enabled`) can disable validation while keeping rules for reporting. Rules are `alt_text_rule` config entities with a rule type (`alt_is_filename`, `alt_is_title`, `not_empty`, `length_limit`, `not_begin_with`, `not_equal`, `not_contain`, `not_end_with`, `regex_match`), a comparison string/limit, an action (`prevent`/`warn`/`off`), and a message; six sensible defaults ship in `config/install`. **Audit:** an `Auditor` service walks every content entity, extracts alt text from image fields and from `<img>` tags inside text fields (via `DOMDocument`), evaluates the rules, and writes rows to a custom `alt_text_validation_audit` table through `AuditStorage`. The audit is populated by cron, by a batch button on the report, or by the `alt-text-validation:queue-audit` Drush command (it uses the Queue API, so it may span several cron runs). Results are shown at **Reports » Alt Text Report** as a View (dependency on `views_data_export` provides CSV download), with custom Views filter (`AtvRuleFilter`, `AtvColumnFieldFilter`) and header (`AtvSummary`) plugins. Two permissions gate the settings/rules and the report. Messages are rendered through two Single-Directory Components (`atv-warning`, `atv-prevent`).

---

- Prevent editors from saving content when an image's alt text is empty (a11y compliance).
- Warn (without blocking) when alt text merely repeats the image filename.
- Block alt text that equals the image title attribute.
- Enforce a maximum alt-text length.
- Forbid alt text that begins with, ends with, equals, or contains a given phrase (e.g. "image of").
- Match alt text against a custom regular expression rule.
- Turn individual rules on as "warn", "prevent", or "off" independently.
- Run in report-only mode: keep rules but disable on-save validation to gather data first.
- Audit every image field across all entity types and bundles for alt-text problems.
- Audit `<img>` tags embedded in rich-text/formatted fields, not just image fields.
- Generate the audit report via cron on a configurable day interval.
- Rebuild the audit report on demand with a batch process from the report page.
- Queue the audit from the command line with `drush alt-text-validation:queue-audit`.
- Download the current audit report as CSV for spreadsheets or stakeholders.
- Filter the report by rule violation or by the field/column that holds the alt text.
- Track audit progress via the report header (start/finish times, status) and `drush queue:list`.
- Roll out gradually: start with a few "warn" rules, then promote them to "prevent".
- Use rules for content strategy, not just a11y (e.g. discourage ambiguous abbreviations).
- See a per-image summary of which warnings/violations apply during editing.
- Customize the report View (columns, filters, exposed filters) like any other view.
- Cover Paragraphs and other nested entities by resolving the hosting "apex" entity.
- Theme the on-save warning/prevent messages by overriding the SDC components.
- Give reviewers report access without giving them rule-administration access (two permissions).
- Skip spurious AJAX-time validation on widget interactions (built-in) while still validating media saves.
