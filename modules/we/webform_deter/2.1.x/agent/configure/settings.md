# Configure Webform Deter

## Config object — `webform_deter.settings`

| Key | Type | Default | Meaning |
|---|---|---|---|
| `warning_message` | string | (long default message, see `WebformDeterSettingsForm::DEFAULT_MESSAGE`) | Text shown in the `window.confirm()` dialog when a pattern matches |
| `patterns` | sequence of strings | `{}` (empty) | JavaScript regular expressions (source strings) tested case-insensitively against field values |

Nothing triggers until `patterns` is non-empty. The JS also only binds when `warning_message.length > 1`.

## Settings form

- Form `Drupal\webform_deter\Form\WebformDeterSettingsForm` (ConfigFormBase).
- Route `webform_deter.settings.form`, path `/admin/config/system/webform_deter/settings`.
- Permission `administer webform_deter` (defined `restrict access: true` in `webform_deter.permissions.yml`).
- `warning_message` is a textarea. `patterns` is a textarea, one regex per line; on submit it is split on
  newlines, each line `trim`ed, empties removed, and stored as a list.

Set with Drush:
```
ddev drush cset webform_deter.settings warning_message "Please do not submit sensitive data." -y
ddev drush cset webform_deter.settings patterns.0 '\d{3}-\d{2}-\d{4}' -y
```

Example patterns (from README): `(dob|birthday|date of birth)`, `[\d \-]{13,19}` (card formats),
`(card number|credit card)`, `\d{9}` (driver's license), `[\d\-]{9,11}` (SSN), `(ssn|social security number)`.

## Runtime behavior (`js/webform_deter.js`)

- `hook_webform_submission_form_alter` (in `webform_deter.module`) attaches library
  `webform_deter/webform_deter` and sets `drupalSettings.webform_deter.warning_message` and `.patterns`.
- The `webform_deter` behavior attaches (via `once`) a `submit` listener to `form[class*="webform"]`.
- On submit it builds `new RegExp(pattern, 'i')` for each pattern and tests every `input[type="text"]` and
  `textarea`. Any match → `window.confirm(warning_message)`.
- Confirm OK → submit proceeds. Cancel → `event.preventDefault()` for that submit, then the check listener is
  removed and replaced by a plain submit handler, so a corrected resubmit is not re-checked. This is a soft
  deterrent; there is no server-side validation or blocking.
- A `debug` drupalSetting (not exposed in the settings form) enables console logging and forces
  `preventDefault` for testing.
