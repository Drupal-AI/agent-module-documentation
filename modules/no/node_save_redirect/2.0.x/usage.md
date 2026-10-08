Node Save Redirect lets you choose, per content type, where a user is sent after creating or editing a node — the edit page, the node view, the content overview, or any custom Drupal path.

---

The module adds two "Redirect user after saving/editing content" detail groups to the *Submission* section of each content type's edit form (`node_type_edit_form`), storing choices in the content type's third-party settings (`node.type.*.third_party.node_save_redirect`) under `save_*` (new content) and `edit_*` (existing content) keys. For each of the create and edit cases you pick a redirect **type** (0 Default, 1 return to edit page, 2 view the new content, 3 content overview `/admin/content`, 4 a custom location), an optional custom **location** path (shown only when type = 4), and a **destination** checkbox to ignore the URL `?destination=` parameter. On node form submit, a submit handler appended to every non-preview submit button reads the content type's settings for the current operation (edit vs. create), optionally strips the `destination` query parameter from the request, and sets the redirect via `$form_state->setRedirectUrl()`, validating any target path through `\Drupal::pathValidator()->getUrlIfValid()`. All hooks are implemented as OOP hook classes (`NodeSaveRedirectHooks`) with `#[LegacyHook]` procedural shims, and `hook_module_implements_alter` reorders the module's `form_alter` to run last. There are no permissions, no config UI beyond the per-content-type form, and no Drush commands.

---

- After creating a node, send the author straight back to its edit form.
- After creating a node, redirect to the published node view.
- After saving, return the user to the `/admin/content` overview.
- Redirect to a custom path (e.g. a dashboard or a "thank you" page) after saving.
- Configure different redirect behavior for creating vs. editing content.
- Set redirect behavior independently per content type.
- Ignore an incoming `?destination=` parameter so your configured redirect wins.
- Preserve core's default behavior (type 0) for content types you don't want to change.
- Streamline an editorial workflow that repeatedly edits the same node.
- Keep bulk content creators on the overview page between saves.
- Route new submissions of a specific type to a moderation queue path.
- Validate custom redirect targets so an invalid path is silently ignored.
- Send editors to a related admin listing after updating a node.
- Avoid landing on the raw node page when a different destination is desired.
- Give each content type a tailored post-save landing page without custom code.
- Let a "create another" style flow return to the node form quickly.
- Override the destination behavior only for edits, not new content (or vice versa).
- Export the redirect rules as part of content-type configuration.
- Direct anonymous-facing content authors to a confirmation page after save.
