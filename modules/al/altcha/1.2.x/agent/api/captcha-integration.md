<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CAPTCHA integration, placement & verification

## Registering the challenge

`altcha_captcha($op, $captcha_type)` implements `hook_captcha()` (from the contrib CAPTCHA
module):

- `$op === 'list'` → returns `['ALTCHA']`, so **ALTCHA** appears as a challenge type.
- `$op === 'generate'` for `ALTCHA` → returns the render array: the `altcha_widget` themed
  element (a `<altcha-widget>` web component) with a `challengeurl` (the self-hosted
  `/altcha/v1/challenge`, or the Sentinel/SaaS URL), `maxnumber`, floating/expire/delay/logo
  attributes, i18n, and `captcha_validate => 'altcha_captcha_validation'`. It is marked
  `cacheable => TRUE` (validation is stateless, so widget pages can be cached).

## Placing ALTCHA on a form

ALTCHA does not place itself — you attach it with the CAPTCHA module's **CAPTCHA points**
(config entity `captcha.captcha_point.<form_id>`), whose `captchaType` is `altcha/ALTCHA`
(`<module>/<challenge>`):

- **UI:** *Configuration → People → CAPTCHA* → add/edit a CAPTCHA point for a form id and
  choose the *ALTCHA* challenge. Or set the site-wide default challenge to `altcha/ALTCHA`.
- **Code:**
  ```php
  \Drupal::entityTypeManager()->getStorage('captcha_point')->create([
    'formId' => 'user_login_form',
    'captchaType' => 'altcha/ALTCHA',
    'status' => TRUE,
  ])->save();
  ```

## Validation flow

`altcha_captcha_validation($solution, $response, $element, $form_state)`:

1. Reads the base64 `altcha` request parameter, base64-decodes and JSON-decodes it into the
   solution payload.
2. Dispatches on `integration_type`:
   - `sentinel_api` → `altcha.sentinel_solution_verification` (`verifyServerSignature`), with
     optional fallback to self-hosted when `sentinel_fallback_enabled` and no `apiKey`.
   - `saas_api` / `self_hosted` → `altcha.self_hosted_solution_verification`
     (`Altcha::verifySolution()` using the State HMAC key).
3. Returns `TRUE`/`FALSE`; CAPTCHA blocks submission on `FALSE`.

## Challenge endpoint & services

- `GET /altcha/v1/challenge` (route `altcha.challenge`, public) →
  `ChallengeController::getChallenge()` builds a challenge with the `altcha-org/altcha` lib
  (SHA-256, 32-byte salt, 1-hour expiry, `max_number` complexity) signed with the secret key.
- Services: `altcha.secret_manager` (`SecretManager` — State `altcha-hmac-key`),
  `altcha.self_hosted_solution_verification`, `altcha.sentinel_solution_verification` (both
  implement `SolutionVerificationInterface`).

There is no plugin type to implement — extend by decorating these services or implementing
CAPTCHA's own hooks.
