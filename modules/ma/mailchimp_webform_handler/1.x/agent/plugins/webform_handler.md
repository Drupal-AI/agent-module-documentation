<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Mailchimp Webform Handler plugin

The whole module is one class: `MailchimpWebformHandler`
(`src/Plugin/WebformHandler/MailchimpWebformHandler.php`), a Webform handler plugin.

## Install & enable

```bash
composer require drupal/mailchimp_webform_handler
drush en mailchimp_webform_handler -y
```

`composer require` pulls the runtime dependency `mailchimp/marketing` (^3.0) and the `webform`
module (^6.2). No install-time config, schema, permissions, routes or services are added.

## Plugin definition

```
@WebformHandler(
  id = "mailchimp_webform_handler",
  label = "Mailchimp Webform Handler",
  category = "Transaction",
  description = "Sends the submission data to Mailchimp.",
  cardinality = CARDINALITY_UNLIMITED,
  results = RESULTS_PROCESSED,
  submission = SUBMISSION_OPTIONAL,
)
```

Because cardinality is **unlimited**, one webform can carry many of these handlers — each with its
own API key, account and target list. `getSummary()` always returns the literal string
"No summary available" on the handler list.

## Attach & configure (UI)

Edit a webform → **Settings → Emails / Handlers → Add handler → Mailchimp Webform Handler**. The
settings form (`buildConfigurationForm()`) shows a *Mailchimp API settings* fieldset:

| Field | Config key | Notes |
|---|---|---|
| Mailchimp API-key | `api_key` | From Mailchimp Account → Extras → API keys. |
| Mailchimp server prefix | `server_prefix` | The datacenter token from your admin URL, e.g. `us19`. |
| *Update Mailchimp lists* (button) | — | AJAX submit (`updateConfigSubmit` → `$form_state->setRebuild()`); re-queries the API and re-renders the fieldset (wrapper id `mailchimp-webform-handler--api-settings`, `ajaxCallback()`). |
| List | `list_id` | `<select>` populated by `getLists()`. |
| Email | `email` | Required. `<select>` of the webform's own elements — maps a webform element onto Mailchimp's required `EMAIL`. |
| *(one per merge field)* | `<MERGE_TAG>` | e.g. `FNAME`, `LNAME`, `PHONE`; `<select>` of webform elements (optional). |

The element option list is built from `webform->getElementsDecodedAndFlattened()`, dropping elements
with no `#title` and `webform_actions`. Merge-field rows only appear once a `list_id` is chosen and
`getMergeFields()` returns fields. `submitConfigurationForm()` writes `api_key`, `server_prefix`,
`list_id`, `email` and each merge-field mapping back into `$this->configuration`.

### Config storage

There is **no** module-owned config object. All keys above are persisted as this handler's settings
inside the **webform config entity** (`webform.webform.<id>`, under `handlers.<uuid>.settings`).
`defaultConfiguration()` seeds `api_key`, `server_prefix`, `list_id`, `email`, `name` to `''`.

## API calls (via the `mailchimp/marketing` SDK)

Every call constructs `new MailchimpMarketing\ApiClient()` and `setConfig(['apiKey'=>…,
'server'=>…])`; the SDK targets `https://<server>.api.mailchimp.com/3.0` over HTTPS (Guzzle).

- `getLists()` → `client->lists->getAllLists(NULL, NULL, 999)`; maps `list->id => list->name`.
  Only runs when both `api_key` and `server_prefix` are non-empty.
- `getMergeFields($list_id)` → `client->lists->getListMergeFields($list_id)`; maps
  `merge_field->tag => merge_field->name`.
- `submitForm()` (on each webform submission) builds:

  ```php
  $data = ['email_address' => $values[$this->configuration['email']], 'status' => 'subscribed'];
  // plus $data['merge_fields'][$tag] = $values[<mapped element>] for each mapped, non-null field
  $client->lists->addListMember($this->configuration['list_id'], $data);
  ```

  New members are always added with status **`subscribed`** (no double opt-in / `pending`, no
  update-if-exists path).

## Behaviour & limitations to know

- **Silent failures.** Every API call is wrapped in `try { … } catch (RequestException $e) {}`
  with an **empty catch** — errors (bad key, wrong server prefix, already-subscribed 400, network
  failure) are swallowed. Nothing is logged and the submitter sees no error; a failed subscribe is
  invisible.
- **`addListMember` rejects existing members.** Mailchimp returns 400 for an email already on the
  list; because the exception is swallowed, re-subscribes appear to "succeed". There is no
  `setListMember`/upsert path.
- **Required email only.** Mailchimp requires `EMAIL`; the `email` mapping is `#required`. Merge
  fields are optional and only sent when the mapped element has a non-null submitted value.
- **Runs on every submission**, synchronously in `submitForm()` — no queue; a slow Mailchimp
  response slows the submit. Use Webform handler **conditions** to activate per submission.
- **No config schema.** The handler settings have no `config/schema`, so strict config-schema
  tooling may warn on the webform entity; settings still save and work.
- The unused `name` default key and the harmless `getListMergeFields` call in
  `submitConfigurationForm()` are minor code smells, not functional blockers.

## Operational tips

- Server prefix is the `usNN`/`usX` token from your Mailchimp admin URL, not the full domain.
- To subscribe to multiple audiences/accounts, add multiple handlers; combine with Webform
  conditional handler settings to pick one per submission (the maintainer's per-language use case).
- Because subscription forwards personal data to Mailchimp, present a clear opt-in and privacy
  notice on the form.
