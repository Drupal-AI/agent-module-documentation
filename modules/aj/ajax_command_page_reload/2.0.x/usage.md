<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Ajax Command Page Reload adds a custom Drupal AJAX command that tells the browser to reload the current page, for the cases where a partial update cannot express what changed. You add it to an `AjaxResponse` with `$response->addCommand(new PageReloadCommand())`.

---

Drupal's AJAX system is a set of commands returned from the server — replace this selector, insert that markup, open a dialog, show a message — and the model works well while the change is local. It works badly when the change is not: a form submission that alters the user's roles, switches the active language, changes a global setting, or does anything the page's cached blocks, menus and contextual links depend on. Replacing one region leaves the rest of the page describing a state that no longer exists, and chasing every affected region with its own replace command is fragile and never quite complete. A reload is the honest answer, and having it as a **command** rather than as a lump of inline JavaScript keeps it inside the AJAX framework where the rest of the response already lives. The module is tiny: `PageReloadCommand` (in `src/Ajax/`) implements `CommandInterface` and `CommandWithAttachedAssetsInterface`; its `render()` returns exactly `['command' => 'pageReload']` — **no URL, no arguments** — and it attaches its own `ajax_command_page_reload/ajax_commands` library. That library's JS registers `Drupal.AjaxCommands.prototype.pageReload`, which calls `window.history.replaceState(...)` (to avoid a form-resubmit prompt) and then `window.location = window.location.href`. The reload target is therefore **always the current URL** — it cannot be redirected elsewhere by the server response. Version **2.0.0** (2024) on `^8` through `^11`, one dependency (`core/drupal.ajax`). Two points of judgement. A reload **discards the state the visitor had** — scroll position, other open dialogs, unsaved input elsewhere on the page — so it should be a considered choice rather than the first reach when a partial update proves fiddly. And on a form, **the redirect after submission** is usually the better tool: Drupal's normal post-submit redirect achieves the same fresh page through the framework's own path, and a reload command is for the cases where there is no submission to redirect from.

---

- Reload the page after an AJAX form submits.
- Refresh the whole page after a role change.
- Reload after switching the active language.
- Update the whole page after a global setting change.
- Refresh cached blocks after an action.
- Avoid replacing many regions at once with separate commands.
- Reload after a bulk operation on the current page.
- Refresh menus after a permission change.
- Reload from a modal dialog's submit handler.
- Keep the reload inside the AJAX command framework.
- Avoid writing inline JavaScript just to reload.
- Refresh contextual links after an edit.
- Update the page after a theme switch.
- Reload after a cart change in an AJAX flow.
- Refresh after enabling or disabling a feature toggle.
- Force a fresh render when cache invalidation is hard to target.
- Reload after a workflow / moderation state transition.
- Refresh the page from a custom AJAX-enabled controller or callback.
- Reuse Drupal's own `AjaxResponse` plumbing instead of a bespoke JS response.
- Trigger a reload from a `#ajax` element's callback without a page redirect.
- Reload after an action taken from a Views AJAX interaction.
