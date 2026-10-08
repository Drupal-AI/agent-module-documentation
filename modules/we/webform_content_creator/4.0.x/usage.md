Webform Content Creator creates a content entity (e.g. a node) whenever a webform is submitted, mapping webform submission values (and tokens) onto the new entity's fields.

---

The module defines a `webform_content_creator` **config entity** ("Webform Content Creator entity"). Each one binds a webform to a target entity type + bundle and stores a per-field **mapping** (`elements`) plus a title mapping and options for synchronization, encryption, and post-submit redirect. Drupal's webform submission hooks (`hook_webform_submission_insert/update/delete`) drive it: on a non-draft submission, every matching config entity's `createContent()` builds the target entity, sets each mapped field from the submission value or a custom token string, and saves it. Field values are applied through pluggable **field mapping** plugins (`@WebformContentCreatorFieldMapping`, e.g. `default_mapping`, plus type-specific ones for entity reference, datetime, address, link, email, boolean, numeric, text, etc.) selected per field. Options include synchronizing/updating or deleting the created content when the submission changes (keyed on a unique field), encrypting mapped values via the Encrypt module, and redirecting the user to the new entity with a message. A `[webform_submission:unmapped_values]` token exposes all not-yet-mapped submission values. You manage everything at *Configuration → Webform Content Creator* (`admin/config/webform_content_creator`, permission `access webform content creator configuration`), including a "Manage fields" form per config entity. It requires the Webform module.

---

- Create a node automatically from each contact-form or registration webform submission.
- Turn a "submit an event" webform into published Event nodes.
- Map a webform's text field to a node's title using tokens (e.g. `[webform_submission:values:name]`).
- Map webform values onto arbitrary content fields (body, date, email, references, etc.).
- Create any content entity type/bundle, not just nodes, from a submission.
- Set a static or token-based title for the created content.
- Update the created content when the submission is edited (edit synchronization).
- Delete the created content when its submission is deleted (delete synchronization).
- Deduplicate/update existing content by a unique field instead of creating a new one each time.
- Encrypt sensitive mapped values using an Encrypt encryption profile.
- Redirect the submitter to the newly created entity with a custom message.
- Use type-aware field mapping plugins for entity-reference, datetime, address, link, or office-hours fields.
- Provide a custom text/token value for a field instead of a direct webform value.
- Include all unmapped submission values in a field via the `[webform_submission:unmapped_values]` token.
- Build a moderated content pipeline where submissions become unpublished drafts for review.
- Populate a CRM-like "Lead" entity from a marketing webform.
- Generate support-ticket nodes from a help-request webform.
- Map a webform file upload to a media/file reference on the content.
- Create taxonomy-tagged content by mapping a webform select to a term reference.
- Keep webform and content in sync for a directory listing maintained via a form.
- Restrict who can configure the mappings with the module's permission.
- Export the mapping configurations as config for deployment.
- Add a new field mapping plugin to support a custom field type.
- Auto-create translated content by mapping language-specific webform values.
- Convert legacy webform-based data entry into structured content entities.
