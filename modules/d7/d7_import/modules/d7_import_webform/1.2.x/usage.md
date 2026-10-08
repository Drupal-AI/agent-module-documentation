D7 Webform Import (submodule of d7_import) recreates Drupal 7 Webform (7.x-4.x) forms as Drupal 11 Webform config entities from a webforms.xml export.

---

This submodule extends D7 Content Import with Webform support. The parent module's export script writes `webforms.xml` automatically when Webform 7.x-4.x is installed on the source site. On D11, the `WebformImporter` service turns each `<webform>` into a `Webform` config entity: D7 components are mapped to D11 webform elements via a fixed `COMPONENT_TYPE_MAP` (textfield, textarea, email, number, select→select/radios/checkboxes, hidden, fieldset→fieldset/details, markup→webform_markup, date, time→webform_time, file→webform_document_file, pagebreak→webform_wizard_page, grid→webform_likert), fieldsets keep their children nested via the D7 `pid` relationship, and root-level pagebreaks partition the form into wizard pages. Form settings map across (confirmation message, confirmation redirect type, submit button label, per-user and total submission limits, preview, draft). Each row of the D7 `{webform_emails}` table becomes a D11 Webform `email` handler, with recipient cid-references rewritten as `[webform_submission:values:{key}:raw]` tokens and `excluded_components` (a CSV of cids) resolved to element keys. It requires `drupal/webform` plus the base `d7_import` module. Two Drush commands are provided (`d7-import:webforms`, `d7-import:webforms-purge`); the parent `d7-import:all` also runs the webform stage when this submodule is enabled. Submissions, conditional logic, per-role access, and non-standard component types are not imported (the latter are logged and skipped).

---

- Migrate Drupal 7 Webform (7.x-4.x) forms into Drupal 11 as native Webform config entities.
- Recreate each D7 webform at `/form/{id}` with a machine id derived from the source node title + nid.
- Map D7 form components to the equivalent D11 webform elements automatically.
- Convert D7 select components to a dropdown, radios, or checkboxes based on the `aslist`/`multiple` flags.
- Parse D7 select `items` (`key|Label` lines) into D11 `#options`, flattening option groups.
- Preserve fieldsets and their nested children, turning collapsible fieldsets into `details` elements.
- Convert D7 pagebreak components into `webform_wizard_page` multi-step pages.
- Translate D7 file components into `webform_document_file` elements with merged allowed extensions and max size.
- Carry over form settings: confirmation message, confirmation redirect, submit label, preview, and draft.
- Map D7 submission limits (per-user and total, with intervals) onto D11 Webform limit settings.
- Recreate each D7 email notification as a D11 Webform `email` handler.
- Rewrite cid-based D7 email recipients as `[webform_submission:values:{key}:raw]` tokens.
- Resolve excluded components (cid CSV) to element keys for each email handler's `excluded_elements`.
- Run the import standalone with `drush d7-import:webforms /path/to/webforms.xml`.
- Run it as part of a full site import with `drush d7-import:all /path/to/export/` (auto-detected).
- Start over cleanly with `drush d7-import:webforms-purge` (deletes all Webform config entities).
- Skip and log any non-standard D7 component type instead of corrupting the imported form.
- Keep the D7 `private` component flag so you can re-check access controls in D11.
