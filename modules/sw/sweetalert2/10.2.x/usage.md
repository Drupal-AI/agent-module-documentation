<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
SweetAlert2 makes the SweetAlert2 JavaScript library available to Drupal and attaches it to every page, so your own JavaScript can replace the browser's stock `alert()` and `confirm()` dialogs with styled modals via `Swal.fire()`.

---

This is a library-wrapper module of the simplest kind. `sweetalert2.libraries.yml` declares the asset library `sweetalert2_js` (which loads `/libraries/sweetalert2/dist/sweetalert2.all.js` and depends on `core/drupal.ajax`), `sweetalert2.install` checks that the library file is present, and `sweetalert2.module` attaches the library on every page through `hook_preprocess_page()`. There is no configuration form, no permission, no block and no route. Because the library is attached site-wide automatically, you do not attach it yourself — enabling the module makes `Swal` available in the browser, and you only write JavaScript that calls `Swal.fire()`. The library itself is **not** bundled with the module: download it separately and save it under `libraries/sweetalert2/dist/sweetalert2.all.js` (the project-root `libraries/` folder), which is exactly what the install-time requirements check verifies — so the classic "I enabled the module but dialogs still look like plain browser alerts" report almost always means the library file is missing, not that anything is broken in code. Install is the usual `composer require drupal/sweetalert2` (or download) then `drush en sweetalert2 -y`; confirm the "sweetalert2 Plugin" line on `/admin/reports/status` reads OK. Once enabled, call the API from any theme or module, e.g. `Swal.fire({icon: 'error', title: 'Oops...', text: 'Something went wrong!'})`; see the [SweetAlert2 examples](https://sweetalert2.github.io) for the full API. The module's version tracks the wrapper, not the underlying library version, so confirm which SweetAlert2 version you actually installed before relying on a specific library API. It has no module dependencies, supports a wide core range (Drupal 8 through 11), and is not covered by Drupal's security-advisory policy. (If you want to fire alerts from server-side Drupal AJAX responses instead of writing your own JavaScript, the separate [SweetAlert](https://www.drupal.org/project/sweetalert) module adds an AJAX command built on this same library.)

---

- Replace the browser's stock `alert()` with a styled modal.
- Replace `confirm()` with a promise-based confirm dialog.
- Show a success toast after an AJAX save.
- Ask the user to confirm a destructive action before proceeding.
- Display a validation error in a modal instead of inline.
- Prompt the user for a single value with `Swal.fire` input.
- Show a loading spinner modal during a long request.
- Chain a sequence of modal steps (a wizard-style flow).
- Auto-dismiss a notification after a timer.
- Present a themed dialog consistent across browsers.
- Confirm before leaving a page with unsaved changes.
- Show an image or HTML body inside a dialog.
- Give custom JavaScript a nicer confirm than `window.confirm`.
- Surface a server error message returned by an AJAX call.
- Provide accessible, focus-trapped modals without hand-rolling markup.
- Reuse one alert style site-wide by loading the library everywhere.
- Prompt for confirmation before submitting a form.
