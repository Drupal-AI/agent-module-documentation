<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Announce-on-auto-submit: hook + JS behavior

Everything the module does. There is no admin UI and no configuration.

## Enable

```
drush en announce_autosubmit -y
```

Core-only (no module deps). Then use a **View with an exposed filter form** whose Views setting
**Exposed form → Auto-submit** is on. No per-View config is added by this module; it activates
automatically for every rendered `views_exposed_form`.

## PHP side — `announce_autosubmit.module`

`announce_autosubmit_form_views_exposed_form_alter(&$form, FormStateInterface $form_state)`
(an `hook_form_FORM_ID_alter` for form id **`views_exposed_form`**) does exactly:

1. Attaches library `announce_autosubmit/announce_autosubmit`.
2. Sets `drupalSettings.announce_autosubmit.forms[$form['#id']].formElementId = $form['#id']`.
3. Iterates `$form['#info']` (the exposed-filter info Views builds) and produces
   `formParameters`, each entry:
   - `name` ← `$field['value']` (the filter's submitted parameter name)
   - `label` ← `$field['label']`
   - `defaultValue` ← `$form[$field['value']]['#default_value'] ?? ''`

   stored at `drupalSettings.announce_autosubmit.forms[$form['#id']].formParameters`.

That is the whole PHP contribution — it only publishes metadata to the page; no server-side state,
request handling, or storage.

## JS side — `js/announce_autosubmit.js`

`Drupal.behaviors.AnnounceFormSubmitBehavior`:

- **On form submit** (per form id in settings, bound once via `core/once`): writes
  `announce_autosubmit.submittedFormId` to `window.localStorage`. For each parameter, on that
  field's `change` it writes `announce_autosubmit.changedFilterLabel` (the field label). This
  localStorage handoff is what lets it announce after a **full page reload** (non-AJAX auto-submit),
  where JS state would otherwise be lost.
- **On `ajaxComplete`** (AJAX auto-submit): reads `changedFilterLabel` and calls
  `Drupal.announce()` with either `New "@label" filter value applied to results` or a generic
  `The filters values have changed and applied to results.`, then clears the stored label.
- **On page load** (covers reload case): if a `submittedFormId` is known and still present in
  settings, it compares `document.referrer` vs `document.URL`. Same path required; then it diffs
  the query parameters (`getParameters()` splits `?…` on `&`/`=`). For each changed filter it calls
  `announceAndFocus()` → `Drupal.announce()` plus `.focus()` on the field (deferred to
  `$(document).ready`). Handles three cases: referrer had no params (announce if value ≠ default),
  current has no params (announce "Filters have been cleared…"), or a value differs between
  referrer and current.

`Drupal.announce()` (core `core/drupal.announce`) writes into a visually-hidden `aria-live` region,
so the message is spoken by screen readers but not visually shown. All user-visible strings go
through `Drupal.t()` with the `@label` placeholder (auto-escaped).

## Scope & limits

- **Views exposed filters only.** The README notes the author hopes to extend it later; as shipped
  it hooks only `views_exposed_form`.
- Announcement text is derived from the **filter labels configured by a site builder** in Views,
  not from arbitrary end-user input.
- Relies on `window.localStorage`; degrades silently (no announcement) where storage is
  unavailable. No effect if the exposed form is not set to auto-submit.
