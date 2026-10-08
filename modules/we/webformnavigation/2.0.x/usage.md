<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Lets users of multi-page (wizard) Webforms jump forwards and backwards between pages via the wizard progress bar/tracker, logging per-page validation errors so they resurface when the user returns to a page and are all shown together on final submit.

---

Webform Navigation makes the Webform wizard progress bar/tracker clickable in both directions. It is enabled per webform through Webform's **Third-party settings** (`forward_navigation`, `prevent_next_validation`, `additional_error_message`) plus a required **Webform Navigation** submission handler (plugin `webform_navigation`). When forward navigation is on, `hook_webform_presave` auto-configures the webform for it: forces `draft = all`, sets an appropriate `purge` mode (+ 365-day `purge_days`), and turns on `wizard_progress_link`. The handler's `alterForm()` grants `#access` to every non-confirmation page, attaches `::validateForm`+`::draft` validators with `formnovalidate`, and displays previously logged errors for the current page; `validateForm()` logs the current page's errors and, on final submit, re-validates all pages (`WebformNavigationHelper::validateAllPages()`) and lists every page's errors. A helper service (`webformnavigation.helper`) records page visits and serialized error data in a custom `webformnavigation_log` table (built on `webform_submission_log`), so navigation state survives across pages and drafts; errors created before a submission exists are stashed in a private tempstore and logged on save. Two theme preprocessors add `is-active`/`has-errors`/`is-complete` (and `webform-progress-bar__page--*`) classes to progress steps, with CSS libraries for the bar and tracker. `prevent_next_validation` additionally relaxes validation on the "Next" button (final submit still validates everything).

---

- Let visitors click any wizard step in the progress bar to jump straight to that page.
- Allow backward navigation to review/edit earlier wizard pages without losing data.
- Allow forward navigation to skip ahead to a later page of a long form.
- Surface a page's validation errors again when the user navigates back to it.
- Aggregate and display all pages' errors on the final submit.
- Add an extra custom message to the final-submit error summary (`additional_error_message`).
- Let users move to the next page without immediate validation (`prevent_next_validation`).
- Colour progress steps by state (active / has errors / complete) via added CSS classes.
- Keep multi-page submissions as drafts automatically (forces draft = all).
- Auto-purge stale drafts to avoid database clutter (sets purge mode + 365-day window).
- Turn the wizard progress bar into a navigation control rather than a static indicator.
- Preserve navigation and error state across draft save/resume.
- Support very long multi-step forms with many wizard pages.
- Log per-page visits for a submission (`webformnavigation_log`, page-visited operation).
- Build accessible step-by-step forms where users self-correct out of order.
- Show a page-scoped error list (item_list themed) titled by the page label on final submit.
- Style the progress **tracker** variant as well as the progress **bar**.
- Debug handler invocation on-screen with the handler's development "debug" option.
- Integrate with `webform_submission_log` for submission-scoped logging.
- Clear a submission's navigation logs automatically when the submission is deleted.
