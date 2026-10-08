<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Confirm Leave (confirm_leave) — agent index

Shows the browser's native "leave site? unsaved changes" prompt when an editor navigates away from a
**modified node add/edit form**. No dependencies (beyond `core/jquery`), no routes, no permissions,
no configuration, no admin UI. Core `^10 || ^11`.
**Release is 8.x-1.0-beta6 — beta.**

The entire module is four files: `confirm_leave.module`, `confirm_leave.libraries.yml`,
`js/confirm-leave.js`, `README.txt`.

Key facts:
- `confirm_leave.module` has two `hook_form_FORM_ID_alter()` implementations — for `node_form` and
  `node_edit_form` — each attaching the library `confirm_leave/confirm-leave`. In practice this means
  it fires on **node content add/edit forms only** (base form id `node_form`); the `node_edit_form`
  hook is legacy and matches nothing on modern core. No hook exists for webforms, config forms,
  comment forms, user forms, or custom entity forms.
- Library `confirm_leave/confirm-leave` = `js/confirm-leave.js` + dependency `core/jquery`.
- JS (`Drupal.behaviors.confirmLeave`): on the `formUpdated` event of any `.form-item`, it adds a
  `form-updated` class to `<form>` and sets `window.onbeforeunload` to return a message; on `submit`
  it sets `window.onbeforeunload = null`. So the prompt appears only after a field is changed and
  never on a normal save.
- **Two behaviours are browser policy, not module limitations** — expect questions about both:
  - the **prompt text cannot be customised**; modern browsers ignore the returned string and show a
    fixed generic message to prevent abuse (the code's `Drupal.t('Are you sure?')` is not displayed);
  - the prompt only fires once the user has **interacted** with a field, so it will not appear on a
    node form merely opened and left untouched.

## What you'd do → where

- **Apply the confirmation to other forms (webform, config form, custom entity form), understand the
  JS mechanism, or hook into the `form-updated` class / `formUpdated` event** →
  [extend/confirm-leave.md](extend/confirm-leave.md)

## Notes

- Nothing to configure and no permission to grant — enabling the module is the whole setup. Node
  add/edit access is already governed by core's node permissions.
- Check two interactions when debugging double-prompts: AJAX-heavy forms (Layout Builder, Paragraphs)
  where dirty-state tracking has more to follow, and core's own unsaved-changes warnings that some
  editing experiences already provide.
- Contrast `autosave_form`, which prevents the loss by saving rather than warning about it.
