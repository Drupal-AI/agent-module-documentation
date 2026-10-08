<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Confirm Leave shows the browser's native "leave site? changes may not be saved" prompt when an editor tries to navigate away from a **node add/edit form** they have modified but not saved.

---

The whole module is four small files and no configuration. Two `hook_form_FORM_ID_alter()` implementations in `confirm_leave.module` attach the library `confirm_leave/confirm-leave` to node add/edit forms (base form id `node_form`), and that library loads `js/confirm-leave.js` (its only dependency is `core/jquery`). The JavaScript listens for Drupal's `formUpdated` event on `.form-item` elements; the first time a field changes it adds a `form-updated` class to the `<form>` and registers a `window.onbeforeunload` handler, so any subsequent attempt to close the tab or follow a link triggers the browser's confirmation dialog. Submitting the form clears the handler (`window.onbeforeunload = null`) so a normal save never prompts. Two behaviours are browser policy rather than module choices and cause most support questions: the **prompt text cannot be customised** (browsers show a fixed generic string to prevent abuse — the module's `Drupal.t('Are you sure?')` is ignored by modern browsers), and the prompt only fires once the user has actually interacted with a field. Out of the box it covers only node content forms; to protect any other form (webform, config form, custom entity form) you attach the same library to it yourself via your own `hook_form_alter()`. There is no admin UI, no permission, and nothing to configure. The current release is **8.x-1.0-beta6** (beta) on core `^10 || ^11`.

---

- Warn before leaving a half-written article on the node add form.
- Prevent losing edits after a mis-clicked link on a node edit form.
- Protect a long content type (many fields) from accidental navigation away.
- Reduce editor frustration and lost-work support requests.
- Warn on closing the browser tab while a node has unsaved changes.
- Guard against an accidental back-button press mid-edit.
- Improve editor confidence in content types without autosave.
- Protect a content translation being entered on a node form.
- Give editors a safety net on a slow or unreliable connection.
- Reduce duplicate work from re-writing a lost draft.
- Attach the `confirm_leave/confirm-leave` library to a webform via `hook_form_alter()` to protect it too.
- Extend the confirmation to a custom entity add/edit form.
- Apply the same warning to a config form your module ships.
- Detect the "dirty" state of a form in CSS/JS via the `form-updated` class it adds.
- Trigger custom behaviour on the `formUpdated` event the module already listens for.
- Provide unsaved-changes protection with zero configuration.
- Add data-loss protection to an editorial workflow without writing JavaScript.
- Ship a lightweight alternative to a full autosave module when you only need a warning.
- Onboard editors unfamiliar with Drupal's save flow more safely.
- Clear the warning automatically on submit so normal saves never prompt.
