Entity CRUD Alter Status Message replaces the default "created / updated / deleted" status message shown after saving or deleting an entity with your own custom, token-aware text.

---

The module lets a site administrator define custom status messages per entity type, bundle and CRUD action for **node**, **taxonomy term** and **media** entities. Each rule is stored as an `entity_crud_alter_status_message` config entity (entity type + bundle + action + message) and managed from an admin listing at `/admin/config/system/entity-crud-alter-status-message`. A `hook_form_alter()` in the `.module` attaches a submit callback to matching entity forms; after the entity is saved (or deleted) the callback finds Drupal's default status message and swaps in the configured text. Messages support Token module placeholders (a token browser is shown on the form) so you can embed entity fields, and legacy `@label` / `@edit_link` placeholders are also supported. It requires the Token module and adds a single `administer entity_crud_alter_status_message` permission.

---

- Replace the default "Article X has been created." node message with a branded confirmation.
- Show a different confirmation for node create vs. update vs. delete.
- Customize the status message per content type (e.g. Article vs. Page).
- Tailor the message shown after adding a media item.
- Customize the message after updating a media item.
- Customize the message after deleting a media item.
- Change the confirmation shown after creating a taxonomy term.
- Change the message shown after editing a taxonomy term.
- Change the message shown after deleting a taxonomy term.
- Embed the saved entity's title in the confirmation using a token (e.g. `[node:title]`).
- Include the author, created date or other entity fields via tokens in the message.
- Use the legacy `@label` placeholder to reference the entity label.
- Use the legacy `@edit_link` placeholder to link back to the entity edit form.
- Give editors clearer, task-specific feedback after content operations.
- Add next-step guidance (e.g. "Now assign this article to a section") after save.
- Standardize post-save wording across an editorial team.
- Localize / reword confirmation text without a custom module.
- Provide friendlier delete confirmations for content editors.
- Set up rules only for the bundles that need special messaging, leaving others default.
- Manage all message overrides from one admin listing (add / edit / delete rules).
- Preview available tokens directly on the message form's token browser.
