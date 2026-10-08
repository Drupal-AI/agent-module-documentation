<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EnvokeService — API client

`src/EnvokeService.php`, service id **`envoke.envoke_service`** (`envoke.services.yml`), constructed
with the `envoke.load_settings.read_only` immutable config (`envoke.settings`) and core `@http_client`
(Guzzle). Get it with `\Drupal::service('envoke.envoke_service')`.

Endpoints (hard-coded, all HTTPS):
- Send: `https://e1.envoke.com/api/v4legacy/send/SendEmails`
- Contacts: `https://e1.envoke.com/v1/contacts`

Auth: HTTP Basic (`'auth' => [$username, $password]`) where username/password are the API ID/KEY from
config. Default ops use `envoke_api_id`/`envoke_api_key`; subscription ops use
`envoke_subscription_api_id`/`envoke_subscription_api_key`.

## Methods

### `sendEmail($to, $message): bool`
Reads `envoke_api_id`/`envoke_api_key`; returns `FALSE` if either is empty. First calls
`insertContactIfNotExist($to)` in a retry loop (backoff `usleep`, `SLEEP_INCREMENT=10000` up to
`SLEEP_LIMIT=60000`) because Envoke requires the recipient to exist as a contact. If the contact
exists, POSTs the message as JSON (`SendEmails` → `EmailDataArray` → `email` → `[$message]`) and
returns true when `$result[0]['result_value'] == "true"`. `RequestException` is caught, logged via
`\Drupal::logger('envoke')` + `Error::logException()`, and returns `FALSE`.

### `insertContactIfNotExist($email, $subscribed = [], $unsubscribed = [], $forSubscription = false): bool`
When `$forSubscription` is true it swaps to the subscription credential pair. GETs
`/v1/contacts?filter[email]=<email>` (`http_errors => false`), retrying on HTTP 401 with the same
backoff. On 200 with a matching contact:
- Non-subscription mode → returns `TRUE` (contact already present).
- Subscription mode → merges the contact's existing `interests` with `$subscribed`(=`"Set"`) /
  `$unsubscribed`(=`"Unset"`), sets `consent_status` back to `Express` if anything was subscribed, and
  PATCHes `/v1/contacts/{id}`; returns `$result['success']`.
If no contact is found it POSTs a new contact (`email`, `consent_status: "Express"`,
`consent_description`, plus interests in subscription mode) and returns `$result['success']`.
`RequestException` on insert → `FALSE`.

### `getContactSubscriptions($email): array`
Uses the subscription credential pair. GETs the contact by email; if found and `consent_status` is not
`Revoked`, returns the contact's `interests`, else `[]`.

Note: `sendEmail` interpolates the recipient email into log messages with a `!email` placeholder
(non-sanitizing token) rather than `@email`.
