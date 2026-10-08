Adds a one-click Disable button to each field's settings form on the Manage display and Manage form display pages, removing the need to drag a field row to the Disabled section.

---

Disable Field Button is a tiny UI-convenience module for the Field UI. On both view displays (Manage display) and form displays (Manage form display), Drupal core normally requires you to drag a field's row to the "Disabled" region at the bottom of the page to stop it from rendering. This module implements `hook_form_alter()` to inject an extra `Disable` submit button (styled `button--danger`) into the per-field settings edit form, alongside the existing Update and Cancel buttons. Clicking it runs a submit handler that calls `removeComponent()` on the display entity being edited and immediately saves it, then shows a status message. There is no configuration, no permission of its own, no config schema, and no services — access is governed entirely by the core Field UI display-form route (e.g. `administer node display` / `administer node form display`). It works for every entity type and bundle that uses Field UI.

---

- Disable a node view-display field in one click at `/admin/structure/types/manage/article/display` instead of dragging its row.
- Disable a node form-display widget at `/admin/structure/types/manage/article/form-display` without scrolling to the Disabled region.
- Quickly declutter a Manage display page that has many optional fields.
- Turn off a field's rendering on a specific view mode (Teaser, Full, RSS, Search index) after opening that view mode's Manage display.
- Turn off a widget on a specific form mode (Default, Register, custom form modes).
- Disable fields on taxonomy term displays at `/admin/structure/taxonomy/manage/tags/overview/display`.
- Disable fields on the user entity display or the user registration form display.
- Disable fields on media type displays and form displays.
- Disable fields on custom content-entity (e.g. Commerce, custom entity) displays that use Field UI.
- Speed up building a new display: add the components you want, click Disable on the ones you do not.
- Give site builders a lower-friction way to hide a field than remembering the drag-to-Disabled convention.
- Reduce accidental drag-and-drop reordering mistakes when the only goal is to disable one field.
- Disable a field whose settings form is open, immediately persisting the change without a separate Save.
- Use on any display where a field row exposes a settings edit form (formatter or widget with a gear/settings button).
- Confirm the change via the "The <field> field has been disabled." status message before moving on.
- Enable the module site-wide with no follow-up configuration step.
- Pair with core Field UI workflows — the button only appears once a field's settings edit form is expanded.
- Manage displays on entity types provided by contrib modules, as long as they use the standard Field UI display forms.
- Trim exposed fields from a print, JSON:API-adjacent, or search-index view mode display quickly.
- Uninstall cleanly at any time — the module stores no data and leaves displays as last saved.
