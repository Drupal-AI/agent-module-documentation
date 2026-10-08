<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Add reCAPTCHA to a webform (the `simple_recaptcha` handler)

This submodule contributes a single Webform handler plugin. Adding it to a webform enables Google
reCAPTCHA on that form only. It has no global settings page — everything is per-handler config plus
the site/secret keys inherited from the parent module.

Class: `Drupal\simple_recaptcha_webform\Plugin\WebformHandler\SimpleRecaptchaWebformHandler`
(`@WebformHandler` id `simple_recaptcha`, `CARDINALITY_SINGLE` = at most one per webform,
`RESULTS_IGNORED` = does not store submission data).

## Add it via the UI

*Structure → Webforms → (your webform) → Settings → Handlers →* **Add handler → reCAPTCHA**
(route `entity.webform.handlers`, `/admin/structure/webform/manage/{webform}/handlers`). Fill the
"Handler settings" fieldset, then save.

## Handler settings

From `defaultConfiguration()` / `buildConfigurationForm()`; schema `webform.handler.simple_recaptcha`.

| Key | Type | Default | Meaning |
|---|---|---|---|
| `recaptcha_type` | radios `v2`\|`v3` | `v2` | `v2` = checkbox widget; `v3` = invisible/score-based. |
| `v3_score` | number 1–100 | `90` | v3 only. Minimum acceptable score; the Google score (0.0–1.0) is multiplied by 100 and compared, so `90` ⇒ requires ≥ 0.90. Higher = stricter. |
| `v3_error_message` | textarea | "There was an error during validation of your form submission, please try to reload the page and submit form again." | v3 only. Shown when validation/score check fails. |
| `hide_badge_v3` | checkbox | `FALSE` | v3 only. Hide the floating reCAPTCHA badge and instead render Google Privacy/Terms links near the submit button (attaches library `simple_recaptcha/hide_badge`). |

The `v3_score`/`v3_error_message`/`hide_badge_v3` fields are shown (via `#states`) only when
`recaptcha_type` = `v3`. Note the schema types `v3_score` as `string` and mislabels both
`recaptcha_type` and `v3_score` as "Message type" — cosmetic; the runtime value is the number above.

## Set it in config (YAML export)

Handlers are stored inside the host webform, e.g. `config/…/webform.webform.contact.yml`:

```yaml
handlers:
  simple_recaptcha:
    id: simple_recaptcha
    handler_id: simple_recaptcha
    label: reCAPTCHA
    status: true
    conditions: {  }
    weight: 0
    settings:
      recaptcha_type: v3
      v3_score: 50
      v3_error_message: 'Sorry, we could not verify you are human. Please retry.'
      hide_badge_v3: true
```

## Set it in PHP

```php
$webform = \Drupal\webform\Entity\Webform::load('contact');
$handler = \Drupal::service('plugin.manager.webform.handler')->createInstance('simple_recaptcha', [
  'id' => 'simple_recaptcha',
  'handler_id' => 'simple_recaptcha',
  'label' => 'reCAPTCHA',
  'status' => TRUE,
  'weight' => 0,
  'settings' => [
    'recaptcha_type' => 'v2',
  ],
]);
$webform->addWebformHandler($handler);
$webform->save();
```

## Where the keys come from

The handler carries NO site/secret key. Verification uses the parent module's global config
`simple_recaptcha.config`: `site_key`/`secret_key` (v2) or `site_key_v3`/`secret_key_v3` (v3).
Configure those first — see
[`../../../../1.0.x/agent/configure/settings.md`](../../../../1.0.x/agent/configure/settings.md).
If the relevant key pair is empty, the parent service silently skips protection and the form renders
unprotected.

## What happens at runtime

`SimpleRecaptchaWebformHandler::alterForm()` runs when the webform is built:

1. If the current user has the `bypass simple_recaptcha` permission, it returns immediately — no
   captcha is added.
2. For `recaptcha_type: v3` it sets `recaptcha_action` to the webform id and calls
   `simple_recaptcha.form_manager` → `addReCaptchaInvisible($form, $form_id, $settings)`.
3. Otherwise (`v2`) it calls `addReCaptchaCheckbox($form, $form_id)`.

The parent `SimpleReCaptchaFormManager` then: fires `hook_simple_recaptcha_bypass_alter` (a module can
set `$result = TRUE` to skip), checks the key pair, attaches the JS library
(`simple_recaptcha/simple_recaptcha` for v2, `simple_recaptcha/simple_recaptcha_v3` for v3), adds a
`#validate` callback `validateCaptchaToken()`, and merges config cacheability into the form. On submit,
`validateCaptchaToken()` POSTs the token to Google's `siteverify` endpoint server-side (or
`recaptcha.net` when the parent config's `recaptcha_use_globally` is on); for v3 it rejects when the
returned score × 100 is below `v3_score`, showing `v3_error_message`.
