<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# BrevoWebformHandler plugin

File: `src/Plugin/WebformHandler/BrevoWebformHandler.php`
Class: `Drupal\brevo_webform_handler\Plugin\WebformHandler\BrevoWebformHandler extends WebformHandlerBase`

## Plugin annotation

```
@WebformHandler(
  id = "brevo_webform_handler",
  label = "Brevo Webform Handler",
  category = "Transaction",
  description = "Sends the submission data to Brevo Contacts API.",
  cardinality = CARDINALITY_UNLIMITED,   // many handlers per webform
  results = RESULTS_PROCESSED,
  submission = SUBMISSION_OPTIONAL,
)
```

Discovered/attached through the Webform handler UI (*Settings → Emails / Handlers → Add handler*).
No standalone admin route — the handler's `configuration` array is persisted inside the parent
**webform** config entity.

## Dependencies

- Drupal module: `webform` (`WebformHandlerBase`, `WebformSubmissionInterface`).
- Composer: `getbrevo/brevo-php:^2.0` — used classes `Brevo\Client\Api\ContactsApi`,
  `Brevo\Client\Configuration`, `Brevo\Client\Model\CreateContact`.
- Guzzle: `GuzzleHttp\Client`, `GuzzleHttp\Exception\RequestException`.

## Configuration keys (`defaultConfiguration()`)

| Key | Meaning |
| --- | --- |
| `api_key` | Brevo v3 API key. Stored in the webform config; used to authenticate every Brevo call. |
| `list_id` | Selected Brevo list id (string; `intval()`-ed at send time). |
| `email` | Machine name of the webform element whose value is the contact email (required mapping). |
| `name` | Declared default, but never read/written by the form or submit code (vestigial). |
| `<attribute>` | One extra key per Brevo "normal" attribute (e.g. `FIRSTNAME`) → webform element machine name. Added dynamically in `submitConfigurationForm()`. |

No `config/schema/*` ships with the module, so these keys rely on Webform's generic handler-settings
schema.

## Settings form — `buildConfigurationForm()`

- Calls `applyFormStateToConfiguration($form_state)` so the current key is live during rebuilds.
- `api_settings` fieldset (`#id = brevo-webform-handler--api-settings`) contains:
  - `api_key` — `#type => 'textfield'`, `#default_value => $this->configuration['api_key']`.
  - `update_lists` — submit button with `#ajax` (wrapper `brevo-webform-handler--api-settings`) and
    `#submit => [updateConfigSubmit]`; `updateConfigSubmit()` only calls `$form_state->setRebuild()`
    so the next build re-queries Brevo with the entered key.
  - `list_id` — `select` from `getLists()`, with a *"- Select a List -"* empty option.
  - When lists exist: a required `fields[email]` select (options = webform elements that have a
    `#title` and are not `webform_actions`), plus one `fields[<attr>]` select per merge field from
    `getMergeFields($list_id)` (each with a leading empty option).
- Returns `setSettingsParents($form)`.
- `ajaxCallback()` returns `NestedArray::getValue($form, ['settings','api_settings'])` to refresh the
  fieldset.

## Save — `submitConfigurationForm()`

Writes `api_key`, `list_id`, `email` from form values; if a list is set, iterates
`getMergeFields($list_id)` and stores each `configuration[$brevo_key]` from
`$form_state->getValues()['api_settings']['fields'][$brevo_key]`.

## Brevo API helpers

- `getLists()`: guards on a non-empty `api_key`; builds a `ContactsApi(new Client(), $config)` where
  `$config = Configuration::getDefaultConfiguration()->setApiKey('api-key', api_key)`. Loops
  `getLists(50, count(sofar))` (50 = Brevo's max page size) until a short page, merging results into
  `[id => name]`. Exceptions swallowed.
- `getMergeFields($list_id)`: builds the same client (note: `$client` is only assigned inside the
  `api_key` guard but used unconditionally in the `try` — with an empty key this raises an
  undefined-variable error). Calls `getAttributes()`, keeps attributes with `category == 'normal'`
  as `[name => name]`. The `$list_id` argument is not actually used to scope attributes.

## Send — `submitForm(form, form_state, WebformSubmissionInterface $webform_submission)`

1. `$values = $webform_submission->getData()`.
2. Build client from `api_key` as above.
3. `$contact = new CreateContact();`
   - `$contact['email'] = $values[configuration['email']];`
   - `$contact['listIds'] = [intval(list_id)];`
   - `$contact['updateEnabled'] = TRUE;` (upsert — existing contact is updated, not errored).
   - Merge fields: for each attribute whose mapped element has a non-null submitted value,
     `attributes_data[$brevo_key] = $values[configuration[$brevo_key]]`; then
     `$contact['attributes'] = (object) $attributes_data;`.
4. `$client->createContact($contact)` inside `try`; `RequestException` is caught and **ignored**
   (empty catch) — failures are silent, and `getSummary()` returns *"No summary available"*.

## Operating notes

- Idempotent per email thanks to `updateEnabled = TRUE`.
- The send is synchronous inside submission handling (no queue); a slow/hung Brevo call slows the
  submit request. There is no retry and no error surfaced to the user.
- To change the target list or mapping, edit the handler and re-run *Update Brevo lists*.
