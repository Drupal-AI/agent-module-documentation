<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "Discord Webhook" webform handler (`discord_webhook`)

## Install & enable

```bash
composer require drupal/discord_webform_handler
drush en discord_webform_handler -y
```

Only dependency is contrib **`webform`** (`webform:webform`). No sub-modules, no permissions of its
own, no Drush commands, no config schema.

## Add it to a webform

The plugin (id **`discord_webhook`**, label *"Discord Webhook"*, category *External*) is a Webform
**handler**, so you attach it per webform, not site-wide:

UI path: *Structure → Webforms → (your webform) → Settings → Emails / Handlers* → **Add handler** →
choose **Discord Webhook** → fill in **Discord Webhook URL** → **Save**.

- `cardinality = CARDINALITY_SINGLE`: at most **one** Discord Webhook handler per webform.
- `results = RESULTS_PROCESSED`: it acts on processed submission results.

The handler config lives inside that webform's config entity
(`webform.webform.<id>` → `handlers.<key>.settings.webhook_url`), not in a standalone config object.

## The one setting

From `defaultConfiguration()` / `buildConfigurationForm()` in `DiscordWebformHandler.php`:

| Setting key | Form field | Meaning |
|---|---|---|
| `webhook_url` | `#type => 'url'`, *"Discord Webhook URL"* | The Discord incoming-webhook URL every submission is POSTed to. Default `''`. |

`submitConfigurationForm()` copies `$form_state->getValue('webhook_url')` into
`$this->configuration['webhook_url']`. There are no other options (no channel/username/avatar/embed
fields, no message template).

To get the URL: in Discord, open the target channel's *Integrations → Create Webhook*, copy the
webhook URL, and paste it into this field.

## What happens on submission

`submitForm(array &$form, FormStateInterface $form_state, WebformSubmissionInterface $webform_submission)`:

```php
$data = $webform_submission->getData();
$client = \Drupal::httpClient();
$webhook_url = $this->configuration['webhook_url'];
$client->post($webhook_url, [
  'json' => [
    'content' => json_encode($data),
  ],
]);
```

- `getData()` returns the submission's element values as an associative array.
- The whole array is `json_encode()`d into a **string**, and that string is placed in the Discord
  `content` field. Discord renders it as a plain-text message containing the JSON — there is no
  Discord embed, no per-field formatting, and no username/avatar override.
- The request uses Drupal's shared **Guzzle** client (`\Drupal::httpClient()`) with default
  options, so **TLS certificate verification is on** and the URL used is exactly the admin-supplied
  webhook URL (submitters cannot change it).

## Error handling

The POST is wrapped in `try/catch`. On failure it logs to the **`webform_discord_webhook`** logger
channel:

```php
DeprecationHelper::backwardsCompatibleCall(\Drupal::VERSION, '10.0.0',
  fn() => Error::logException(\Drupal::logger('webform_discord_webhook'), $e),
  fn() => watchdog_exception('webform_discord_webhook', $e));
```

`DeprecationHelper` picks `Error::logException()` on Drupal ≥ 10 and legacy `watchdog_exception()`
below it.

## Caveats (from source)

- The `catch` clause names `RequestException` **without importing it** and without a leading
  backslash, so it resolves to a non-existent class in this plugin's namespace. A Guzzle
  `RequestException` (connection/HTTP error) therefore is **not** matched by the catch and would
  propagate uncaught instead of being logged. Treat the "errors are logged, submission still
  succeeds" behaviour as unreliable for network-level failures.
- The POST is **synchronous** inside `submitForm()`: a slow or unreachable Discord endpoint blocks
  the submission request for the duration of the HTTP call/timeout.
- The message body is the raw `json_encode($data)` dump — no field labels, no redaction, and no
  size handling. Very large submissions may exceed Discord's message limits.
