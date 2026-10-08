<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enable Webform Navigation on a webform

There is no global settings page. Configuration is per webform and requires **two** things.

## 1. Third-party settings

On `admin/structure/webform/manage/<id>/settings`, in **Third-party settings → Webform navigation
settings** (added by `hook_webform_third_party_settings_form_alter`, stored under third-party key
`webformnavigation`):

| Setting | Type | Effect |
|---|---|---|
| `forward_navigation` | checkbox | Master switch. Makes all non-confirmation wizard pages clickable/accessible, enables per-page error logging, **and** (via `hook_webform_presave`) forces `draft = all`, sets `purge`/`purge_days = 365`, and `wizard_progress_link = TRUE`. |
| `prevent_next_validation` | checkbox (visible when forward on) | Relaxes validation on the wizard **Next** button (uses `::validateForm`+`::draft` only). Final submit still validates every page. |
| `additional_error_message` | textfield | Extra text appended to the final-submit error summary. |

Also enable the wizard progress bar itself: **Form** settings → "Show wizard progress bar".
(Only schema-declared key is `forward_navigation`; the other two are stored as third-party settings too.)

## 2. The submission handler

Add the **Webform Navigation** handler (plugin `webform_navigation`, `WebformNavigationHandler`,
cardinality single) under the webform's **Emails / Handlers** tab. Without it, forward navigation
does nothing — the third-party settings form shows a warning to this effect. The handler's only
own config is a development **debug** checkbox (`defaultConfiguration: ['debug' => FALSE]`) which,
if on, prints each invoked handler method on-screen to all users (dev aid only).

## What the handler does at runtime (`alterForm`)

When `forward_navigation` is on and the webform `hasWizardPages()`:
- Sets `#access = TRUE` on every page except `webform_confirmation`, attaches validators
  `['::validateForm','::draft']` and `formnovalidate` so users can move without full validation.
- Applies the same to the `wizard_prev` and `draft` actions.
- Logs the current page visit and re-displays any previously logged errors for that page.
- On final submit (`::complete`), `validateAllPages()` runs and all pages' errors are listed,
  each titled by its page label (`item_list`).
