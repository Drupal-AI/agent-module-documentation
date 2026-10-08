<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Sanitize Submissions (webform_sanitize_submissions) — agent index

**Webform handler that deletes flagged element values from stored submissions after processing.**

- **Version:** 1.0.x  (info.yml `1.0.1`)  •  **Core:** ^10 || ^11  •  **Depends on:** webform
- **Handler:** `@WebformHandler("sanitize_submission")`, single-cardinality — `src/Plugin/WebformHandler/SanitizeSubmissionWebformHandler.php`
- **Per-element setting:** `sanitize` checkbox added via `hook_webform_element_default_properties_alter()` + `hook_webform_element_configuration_form_alter()` (`.module`)
- **When:** `postSave()` — for each element with `#sanitize`, `DELETE FROM webform_submission_data WHERE sid=… AND name=…`, then `setElementData(name, NULL)` + `resetCache()`; no-op if results disabled

**Security:** No routes or custom permissions; all configuration is through Webform's admin UI (permission-gated by Webform). This is a data-minimization/privacy feature. Deletes use the DB API with parameterized `->condition('sid', …)` / `->condition('name', …)` — no SQL string concatenation. Deletion intentionally bypasses entity hooks (raw table delete) so earlier handlers can still read the value; values are cleared only after `postSave`. No anonymous or mutating endpoints beyond normal webform submission.

See [configure/handler.md](configure/handler.md)
