<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Feedback block & AJAX submit flow

## Block plugin
`Drupal\did_this_help\Plugin\Block\DidThisHelpBlock` (`src/Plugin/Block/DidThisHelpBlock.php`),
annotation `@Block(id = "did_this_help", admin_label = "Did this help?")`,
implements `ContainerFactoryPluginInterface` (injects `form_builder`).
`build()` returns `$this->formBuilder->getForm(DidThisHelpForm::class)` and forces
`$form['#cache'] = ['max-age' => 0]` so the widget is never page-cached. Place it via block layout.

## The form
`Drupal\did_this_help\Form\DidThisHelpForm` (`src/Form/DidThisHelpForm.php`), extends `FormBase`,
form id `did_this_help_form`. Injects `title_resolver` and `current_user`
(`create()` / constructor). Attaches library `did_this_help/did_this_help` and class
`did-this-help`.

`buildForm()` structure:
- `question` markup — the configured `did_this_help.settings:question` in a `.question` div.
- `yes` submit button — `#ajax` callback `::sendAjaxForm`.
- `no` submit button — no AJAX; the JS behavior toggles the reasons panel client-side.
- `no_choice_wrapper` container:
  - `no_list` radios — options built from `explode(PHP_EOL, no_answers)` plus an appended `Other`.
  - `message` textarea — 3 rows, `maxlength` 250, description "Limit to 250 characters".
  - `send` submit button — `#ajax` callback `::sendAjaxForm`.
- Hidden `title` (from `title_resolver->getTitle()` for the current route) and hidden `path`
  (from `path.current`). These carry the page identity into the stored row.

`submitForm()` is empty; all work happens in the AJAX callback.

## AJAX callback `sendAjaxForm()`
Reads `op` (the clicked button's untranslated string) and branches:
- **`Yes`** → `choice = 'Yes'`, empty `choice_no`/`message`.
- **`Send`** → `choice = 'No'`, `choice_no` resolved from the selected radio's server-side
  `#options` label, `message` from the textarea value.
- **default** → returns an error markup ("Something went wrong…").

Builds `$data` with `uid` (current user), `path`, `title`, `choice`, `choice_no`, `message`, calls
`_did_this_help_send_info($data)`, then replaces the form via
`ReplaceCommand('form[id^=did-this-help-form]', …)` with "Thank you for your feedback."

## Storage helpers (`did_this_help.module`)
- `_did_this_help_send_info($data)` — runs `Html::escape()` on `path`, `title`, `choice`,
  `choice_no`, and `message` (message also `substr(...,0,100)`), sets `ip_address` from
  `Drupal::request()->getClientIp()`, then dedupes: `_did_this_help_row_exist()` matches on every
  column; if a matching row exists it `_did_this_help_row_update()`s (refreshes `created`),
  otherwise `_did_this_help_row_save()` inserts. All use the DB API query builder with bound
  conditions (no raw SQL, no entity API).
- Table `did_this_help` columns: `id` (serial PK), `path` varchar(1024), `title` varchar(1024),
  `uid` int, `choice` varchar(32), `choice_no` varchar(1024), `message` varchar(256), `created` int,
  `ip_address` varchar(128) (widened from an earlier length by update `9001`).

## Client behavior (`js/did-this-help.js`)
`Drupal.behaviors.didThisHelp` (jQuery + `once`): clicking the "No" button `preventDefault`s and
toggles/positions the `.no-choice-wrapper` panel; selecting a radio reveals the message field and
focuses it; clicking outside hides the panel. Pure UI — the actual submit is the AJAX form above.
