# REST & SOAP handler configuration

Both handlers are added per-Webform (no global settings). UI: *Webform → Settings →
Emails / Handlers → Add handler → REST* (or *SOAP*). Config saves into the Webform entity.
Send happens in `postSave()` when the submission state is `completed` or `updated`.

## REST handler (`rest_handler`)

Settings (config key → meaning; defaults from `defaultConfiguration()`):

| Key | Type | Notes |
|---|---|---|
| `method` | radios `post`/`put` | default `POST`. `put` sends no urlencoding step. |
| `endpoint` | textarea (required) | Target URL. Token-replaced. A leading `/` is rewritten to `<current-host><path>` (posts back to same host). |
| `endpoint_oauth_token` | textfield | OAuth token URL (used when `auth_type=oauth`). |
| `auth_type` | radios `basic`/`oauth` | default `basic`. |
| `username` / `password` | textfield | Basic: HTTP userpwd. OAuth: client_id / client_secret. |
| `request` | textarea (required) | Payload template; Drupal tokens allowed (`[webform_submission:values]`, field tokens, `[oauth:token]`). |
| `headers` | textarea | One header per `\r\n`. Empty → `Content-Type: application/json` (basic) or `application/x-www-form-urlencoded` (oauth). If body is form-urlencoded the JSON payload is converted to `k=rawurlencode(v)&…`. |
| `response` | textfield | Dotted path into the JSON response (e.g. `Body.Success`) used to decide success. |
| `success_value` | textfield | If set, success = (`response` value == this). Else success = the response value is boolean true. |
| `message` | textfield | Dotted path to a status message shown to the user (addMessage on success / addError on failure). |
| `result_values` | textarea (JSON) | Map of `submission_key: response.dotted.path`; matched values are written back into the submission and it is `resave()`d. |
| `purging` | checkbox | Delete the submission after send (regardless of success — happens before result validation returns). |
| `enablesslverification` | checkbox | **Off by default** → `CURLOPT_SSL_VERIFYPEER = FALSE`. Tick to verify TLS. |
| `base64encode` | checkbox | Base64-encode the whole payload. |
| `base64string` | textfield | If set with `base64encode`, wrap as `{"<base64string>": "<payload>"}`. |
| `base64response` | textfield | Response key whose base64 value is decoded before parsing. |
| `debug` | checkbox | Echo sent message + response to the screen and logger. Do not enable in production. |

Payload build (`getMessage()`): for OAuth, a client-credentials token is fetched from
`endpoint_oauth_token` via cURL and substituted for `[oauth:token]` in `request`. Tokens are
replaced with the `_webform_remote_handlers_token_cleaner` callback (escapes non-`:files:`
values with `addslashes`); `&quot;`→`\"`, HTML entities decoded, newlines/tabs stripped.

File token: `[webform_submission:files:<element_key>[:<separator>]]` (from
`webform_remote_handlers_token_info()`) returns the base64-encoded contents of the file(s) in
that element, joined by the separator (default `,`).

## SOAP handler (`soap_handler`)

| Key | Type | Notes |
|---|---|---|
| `wsdl` | url | WSDL URL, or empty for non-WSDL mode. |
| `endpoint` | url (required) | Used as both SOAP `location` and `uri`. |
| `username` / `password` | textfield | SOAP `login` / `password`. |
| `request` | textarea (required) | Raw request body, token-replaced, sent via `__doRequest()`. |
| `response` | textfield (required) | XPath local-name matched against the response to detect success (non-empty = posted). |
| `bypass_ssl` | checkbox | **When ticked**, sets `verify_peer=false`, `verify_peer_name=false`, `allow_self_signed=true` on the stream context. |
| `purging` | checkbox | Delete submission after send. |
| `debug` | checkbox | Echo message + response to screen. |

## Attaching in code / config

Handlers are standard Webform handler config; add under a Webform's `handlers:` mapping with
`id: rest_handler` (or `soap_handler`) and a `settings:` map of the keys above, or use the UI.
`getSummary()` shows the endpoint on the handlers list.
