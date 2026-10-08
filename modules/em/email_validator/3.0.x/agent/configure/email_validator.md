<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure EVA - Email Validator

- **UI route:** `email_validator.settings` → `/admin/config/system/email-validator` (menu: Configuration » System » "EVA - Email Validator"). Requires permission `administer eva api settings`.
- **Config object:** `email_validator.settings` (schema in `config/schema/`, defaults in `config/install/`). Editable via Drush: `drush cget email_validator.settings`, `drush cset email_validator.settings <key> <value>`.

## Settings keys

| Key | Type | Meaning |
|---|---|---|
| `general.api_key` | string | e-va.io Access Key. Sent in the `api-key` request header. **Required** in the form. Stored as plain text; treat exported config as sensitive. |
| `configuration.forms` | string (textarea, one entry per line) | Forms to validate, each `form_id:field`. `field` may be dotted for nested values (`elements.email`). Default `user_register_form:mail`. |
| `protection.states_all` | boolean | "Disable EVA". When `TRUE`, all states are allowed and **no API call is made** (validation effectively off). |
| `protection.email_states` | sequence of int | Allowed states: `0`=Safe, `1`=Unknown, `2`=Invalid, `3`=Risky. An address is accepted only if its returned state is in this list. Default `[0, 1]`. |
| `logs.wrong_emails` | boolean | Log rejected addresses to the Drupal logger channel `email_validator`. Default `TRUE`. |
| `logs.system_down` | int/bool (radios) | Policy when the API errors/has no credits: `0` = reject all validations (fail closed), `1` = bypass/accept all (fail open). Default `TRUE`/`1`. |

## Form-targeting syntax (`configuration.forms`)

One line per target, `form_id:field`. The module's `hook_form_alter` adds a validator to any listed `form_id`; on submit it reads the address from `field` and rejects with "The email address … is not valid." if EVA says so. Special cases handled in code:

- `commerce_checkout_flow_multistep_default` → reads `contact_information[email]`.
- Any form id containing `webform_submission` → reads the field from the submission's `elements`.
- Otherwise → reads `form_state->getValue(field)`.

Example (multiple lines):

```
user_register_form:mail
commerce_checkout_flow_multistep_default:contact_information
```

## Behavior notes

- Validation results are cached per address for 1 hour (`cache.default`, cid `email_validator_api:<email>`).
- With `states_all` off and `email_states` non-empty (the default), EVA also replaces core's `email.validator`, so core email validations can trigger the API too — see [api/email_validator.md](../api/email_validator.md).
- The endpoint is hardcoded to `https://e-va.io/api/email/validate/` (not configurable); the call uses HTTPS with default TLS certificate verification.
