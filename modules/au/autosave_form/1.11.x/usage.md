Autosave Form periodically saves the state of Drupal forms in the background so editors don't lose work, and offers to restore an autosaved draft the next time the form is opened.

---

Autosave Form decorates core's form builder, validator, and error handler so that, on a configurable interval, the current values of a form are serialized and stored server-side without a full submit. If the browser crashes, the session times out, or the editor navigates away, the unsaved state is kept; when they return to the same form they are prompted to restore or reject the autosaved draft. It works primarily on content entity edit forms (and optionally config entity forms), and can be limited to specific entity types and bundles, and to new-entity create forms. A small notification ("Saving draft…") can be shown on each autosave, with configurable text and duration. Everything is controlled from a single settings form at Admin → Configuration → Content authoring → Autosave Form: the interval in milliseconds, whether to autosave only when the form actually changed, which entity types/bundles are covered, and the notification behavior. Autosaved states are stored in a database backend (`autosave_form.entity_form_storage`) and purged automatically when the entity is saved, updated, or deleted, or when relevant config changes. Because it hooks in at the form-system level, no per-form code is required for standard entity forms; developers can extend coverage to custom forms via the module's form interface and traits.

---

- Prevent editors from losing a long article if the browser crashes.
- Auto-save node edit forms every 60 seconds in the background.
- Prompt users to restore an autosaved draft when reopening a form.
- Let a user reject a stale autosaved draft and start fresh.
- Limit autosave to specific content types (e.g. only long-form articles).
- Restrict autosave to chosen entity types and bundles.
- Enable autosave on config entity forms as well as content forms.
- Turn autosave on for new-entity create forms.
- Show a "Saving draft…" toast each time autosave runs.
- Customize the notification message and how long it stays visible.
- Autosave only when the form has actually changed (experimental).
- Recover in-progress edits after a session timeout.
- Warn a user if the entity was saved by someone else meanwhile.
- Reduce accidental data loss on large multi-field forms.
- Give reviewers confidence to leave a form open across a break.
- Tune the autosave interval to balance load vs. safety.
- Purge autosaved state automatically once the entity is saved.
- Clear autosaved drafts when the entity is deleted.
- Protect webform-like long entity forms from data loss.
- Store autosaved form state in the database backend.
- Add autosave to a custom form via the form interface and traits.
- Programmatically read or purge a user's autosaved state via the storage service.
- Keep drafts per user, per form, and per language.
- Improve editorial UX on slow or unreliable connections.
