Unique Field Ajax lets you mark a single-value field (or a content type's title) as unique per bundle and optionally per language, validating on submit and, optionally, live via AJAX as the editor types.

---

The module adds a "Unique field settings" section to the *field settings* form (`field_config_edit_form`) for single-cardinality fields of eligible types (`string`, `string_long`, `list_string`, `text`, `email`, `entity_reference`, `path`, `uri`, `link`, `integer`, `decimal`, `color_field_type`), and a "Unique title settings" section to the *content type* add/edit form that governs the node title. The choices are saved as **third-party settings** under the `unique_field_ajax` namespace on the `field.field.*` config entity (or on the `node.type.*` entity for titles): `unique`, `per_lang`, `case_sensitive`, `use_ajax`, `no_enforce`, `message`, and `message_warning`. At form build time the module attaches an `#element_validate` callback (`unique_field_ajax_validate_unique`) to the widget; when `use_ajax` is on it also attaches an `#ajax` process wrapper (event `finishedinput`, library `unique_field_ajax/unique_event`) that checks the value live and shows an inline error/warning. Uniqueness is tested by `unique_field_ajax_is_unique()`, an entity query scoped to the field, the entity's bundle, the current entity id (excluded), optionally the language, using `=` or `LIKE BINARY` for case sensitivity. If `no_enforce` is set the check only shows a warning (class `warning`) and still allows saving; otherwise it sets a form error. Custom messages support `%link` (a link to the conflicting entity) and `%label` (the field label) tokens. Two alter hooks — `hook_query_unique_field_ajax_alter()` and `hook_unique_field_ajax_unique_results_alter()` — let other modules adjust the query or its results. There is no admin settings page (no configure route) and no permission of its own.

---

- Require an SKU/product-code field to be unique across all nodes of a bundle.
- Prevent two events from sharing the same slug or reference number.
- Enforce unique email addresses on a custom contact or membership content type.
- Make a content type's node title unique so editors cannot create duplicate titles.
- Give editors live AJAX feedback that a value is already taken, before they submit.
- Show a soft warning (but still allow saving) for near-duplicate values via "don't enforce".
- Allow the same value in different languages by enabling "per language" uniqueness.
- Enforce case-sensitive uniqueness so "Acme" and "acme" are treated as different.
- Enforce case-insensitive uniqueness so "Acme" and "acme" collide (the default).
- Add a custom error message telling the editor exactly which record already uses the value.
- Use the `%link` token to link the editor straight to the conflicting entity.
- Use the `%label` token to include the field label in the error/warning text.
- Keep invoice numbers unique on a commerce or custom entity's field.
- Ensure a "machine-name-like" text field stays unique within a bundle.
- Deduplicate an imported catalogue by flagging repeated reference fields on save.
- Validate uniqueness on inline entity forms (IEF) and media library upload forms.
- Constrain a taxonomy-referencing field so each term is used by at most one node.
- Enforce unique short URLs / redirect keys stored in a link or uri field.
- Alter the uniqueness query with `hook_query_unique_field_ajax_alter()` to add extra conditions.
- Post-process matches with `hook_unique_field_ajax_unique_results_alter()` (e.g. always fail or ignore some).
- Apply uniqueness per bundle so the same value can exist in a different content type.
- Give a throttled, keyup-delayed AJAX check (event `finishedinput`) rather than one request per keystroke.
- Roll out field uniqueness entirely through exported config (third_party_settings) for deployment.
- Combine enforce-off warnings with a custom guidance message to nudge editors without blocking them.
