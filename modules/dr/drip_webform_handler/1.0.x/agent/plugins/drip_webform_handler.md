<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform handler: DripWebformHandler

Class `Drupal\drip_webform_handler\Plugin\WebformHandler\DripWebformHandler`
(`src/Plugin/WebformHandler/DripWebformHandler.php`), extends
`Drupal\webform\Plugin\WebformHandlerBase`.

## Plugin annotation

```
@WebformHandler(
  id = "drip_webform_handler",
  label = "Drip.com Webform Handler",
  category = "Transaction",
  description = "Sends the submission data to Drip.com",
  cardinality = CARDINALITY_UNLIMITED,
  results = RESULTS_PROCESSED,
  submission = SUBMISSION_OPTIONAL,
)
```

Unlimited cardinality means you can add several Drip handlers to one webform (e.g. different
accounts/tags).

## Install & enable

1. `composer require drupal/drip_webform_handler` — this also pulls `drewm/drip:^0.9.0` (the REST
   client) and `drupal/webform:^5.16 || ^6`.
2. `drush en drip_webform_handler` (Webform must be enabled).
3. No settings route, no permissions, no config schema ship with the module — configuration is
   done entirely inside a webform's handler UI.

## Configuration form (`buildConfigurationForm()` / `submitConfigurationForm()`)

Fields, all under an `api_settings` fieldset, saved into the handler's `$this->configuration`:

- `api_key` — textfield, *"Drip.com API-key"*. The Drip API token (found on the Drip User Info
  page).
- `account_id` — textfield, *"Drip.com numeric Account ID"* (from the Drip dashboard URL).
- `tags` — textfield, pipe-separated, e.g. `tag1|tag2|tag3`. Stored as one string.
- `eu_consent` — select: `granted` / `denied` / `unknown` (forces the subscriber's GDPR consent
  value).
- one **select per Drip subscriber field** (from `getSubscriberFields()`) whose options are the
  webform's mappable elements plus a *"Please select"* blank. Each select value (a webform
  element key) is saved as `$this->configuration[<field_name>]`.

`defaultConfiguration()` only declares `api_key` and `account_id`; `tags`, `eu_consent` and the
per-field mappings are populated once the form is saved.

### Mappable elements (`getMappingOptions()`)

Only webform elements whose `#type` is **`textfield`** or **`email`** are offered as mapping
targets; the option label is the element `#title`, the value is its key.

### Drip subscriber fields (`getSubscriberFields()`)

`email`, `first_name`, `last_name`, `address1`, `address2`, `city`, `state`, `zip`, `country`,
`phone`, `time_zone`, `ip_address` (properties per Drip's `#subscribers` API docs).

## What is sent, and how (`submitForm()`)

On each submission:

1. `$values = $webform_submission->getData()`.
2. `$client = new Drip($api_key, $account_id)` — the `DrewM\Drip\Drip` client (drewm/drip),
   which authenticates to Drip and calls its REST API over HTTPS via Guzzle.
3. Builds a plain array: `tags` = `explode('|', $tags)`, `eu_consent` = the selected value, then
   for every subscriber field `dataset[$field] = $values[$mappedElementKey] ?? ''`.
4. Wraps it in `new Dataset('subscribers', $dataset)` and calls
   `$client->post('subscribers', $dataset)` — i.e. Drip's **create/update subscribers** endpoint
   for the configured account.
5. A `GuzzleHttp\Exception\RequestException` is caught with an **empty body**, so Drip/network
   failures are silently swallowed (no Drupal log entry, no user message, submission still
   succeeds locally).

The endpoint is fixed inside the drewm/drip client (Drip's own API host); the module never fetches
a request- or config-supplied URL.

## Attaching the handler to a webform

1. *Structure → Webforms* (`/admin/structure/webform`) → edit the target form.
2. *Settings → Emails / Handlers → Add handler* → choose **Drip.com Webform Handler**.
3. Enter the Drip API token and numeric account ID, set optional tags and the GDPR consent value,
   and map each Drip field to a webform textfield/email element (leave *Please select* to skip a
   field — it is sent as an empty string).
4. Save. Handler settings persist on the webform config entity. Add the handler again for a second
   Drip target if needed.

## Notes / caveats

- The API token is stored as a **plain textfield in the webform handler configuration** (part of
  the exported webform config); the module offers no Key-entity or environment-variable
  integration.
- Unmapped subscriber fields are always transmitted as empty strings (they are still keys in the
  dataset).
- Because the `catch` block is empty, delivery problems are invisible in Drupal — verify receipt
  in the Drip dashboard when testing.
