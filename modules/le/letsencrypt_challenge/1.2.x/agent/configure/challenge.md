<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the Let's Encrypt challenge value

Admin form route `letsencrypt_challenge.challenge_form` → `/admin/config/letsencrypt_challenge/challenge`
(`options: { _admin_route: TRUE }`, `requirements: { _permission: 'administer letsencrypt challenge' }`).
Menu link `letsencrypt_challenge.challenge_form` sits under `system.admin_config_system` (weight 99).
Form class `\Drupal\letsencrypt_challenge\Form\ChallengeForm` extends `ConfigFormBase`, but
`getEditableConfigNames()` returns `[]` — nothing is written to configuration; the value is stored in
**state** (constructor injects `state`).

## Form field

| Field | #type | Value key | Notes |
|---|---|---|---|
| Challenge string | `textfield` | `challenge` | `#maxlength` 512, `#size` 128; `#default_value` = current state value |

`submitForm()` calls `parent::submitForm()` then
`$this->state->set('letsencrypt_challenge.challenge', $form_state->getValue('challenge'))`.

## The stored value (state, no config object, no schema)

Lives in the key/value **state** store, not in configuration:

- Key: `letsencrypt_challenge.challenge`
- Default when unset: `''` (empty string)

Set/read without the UI:

```php
\Drupal::state()->set('letsencrypt_challenge.challenge', 'TOKEN.KEY_AUTHORIZATION');
$value = \Drupal::state()->get('letsencrypt_challenge.challenge', '');
```

Via Drush:

```bash
drush state:set letsencrypt_challenge.challenge 'TOKEN.KEY_AUTHORIZATION'
drush state:get letsencrypt_challenge.challenge
```

Being state, the value is not carried in a config export. `hook_uninstall()` deletes the key.

## What happens at request time

`\Drupal\letsencrypt_challenge\Controller\ChallengeController::content()`:

1. Builds `new CacheableResponse('', 200)`.
2. Sets the body to `$this->state->get('letsencrypt_challenge.challenge', '')`.
3. Returns the response.

The method takes no parameters. The `{key}` segment of `/.well-known/acme-challenge/{key}` is never
consulted, so every request returns the same single stored value — the module handles one manual
challenge at a time, not several concurrent tokens. Typical manual flow: run your ACME client in
manual mode, paste the key authorization it prints into the form, save, then let the ACME server
fetch the well-known path.

Both serving routes set `_disable_route_normalizer: 'TRUE'` so the path is matched exactly as the
ACME server requests it (no trailing-slash / case normalization).

### Apache note
On Apache you may need to allow the `.well-known/acme-challenge` path through in `.htaccess`
(drupal.org issue #2408321) so the request reaches Drupal instead of being served/blocked by the
web server.
