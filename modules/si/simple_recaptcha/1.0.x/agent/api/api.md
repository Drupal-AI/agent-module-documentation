<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API — form manager service, bypass hook & permission

## `simple_recaptcha.form_manager` service

`\Drupal\simple_recaptcha\SimpleReCaptchaFormManager` (args: config.factory, http_client,
logger.factory, module_handler, session). Public methods:

| Method | Purpose |
|---|---|
| `addReCaptchaCheckbox(array &$form, $form_id)` | Inject the **v2** "I'm not a robot" checkbox + libraries into `$form`. |
| `addReCaptchaInvisible(array &$form, $form_id, array $configuration)` | Inject **v3** invisible token; `$configuration` has `v3_score`, `recaptcha_action`, `hide_badge_v3`. |
| `validateCaptchaToken(&$form, FormStateInterface &$form_state)` | Form validate handler that verifies the token with Google server-side. |
| `clearSessionData(&$form, FormStateInterface &$form_state)` | Submit handler clearing captcha session state. |
| `formIdInList($needle, array $haystack)` *(static)* | Wildcard match a form ID against the configured list (`*` → `.*`). |

You normally don't call these directly — `hook_form_alter` wires them up from
`simple_recaptcha.config`. Use them to add reCAPTCHA to a form you build yourself.

## Attach mechanism (recap)

`simple_recaptcha_form_alter()`:
1. returns early if the user has `bypass simple_recaptcha`;
2. matches `$form_id` against `form_ids` (or protects all if `recaptcha_use_globally`);
3. calls `addReCaptchaInvisible()` for `recaptcha_type: v3`, else `addReCaptchaCheckbox()` for v2.

## Bypass permission & hook

- **Permission `bypass simple_recaptcha`** — any user with it skips reCAPTCHA on every form.
- **`hook_simple_recaptcha_bypass_alter(&$form, &$result)`** (in `simple_recaptcha.api.php`) —
  set `$result = TRUE` to leave a given form unprotected:

```php
function MYMODULE_simple_recaptcha_bypass_alter(&$form, &$result) {
  if (\Drupal::currentUser()->hasPermission('administer content')) {
    $result = TRUE; // no reCAPTCHA for content admins
  }
}
```

The other permission, `administer simple_recaptcha`, only gates the settings form.
