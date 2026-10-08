<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# eca_remote_request — plugins

## Action: Run Remote Requests (`eca_remote_request_run_remote_requests`)
Config fields (set in the ECA model):
- `url` (required) — endpoint. Taken verbatim from config (not token-replaced in code).
- `method` — GET/POST/PUT/PATCH/DELETE/HEAD/OPTIONS.
- `post_type` — `form_params` or `json` (used for PATCH/POST/PUT bodies).
- `data` — YAML, token-replaced, decoded and placed under the `post_type` key.
- `options` — YAML of Guzzle request options, token-replaced (headers, auth, proxy, verify, timeout…).
- `token_name` — ECA token to receive a DataTransferObject with `status`, `headers`, `contents`.

Flow (`execute()` in `src/Plugin/Action/RunRemoteRequestsAction.php`): decode `options` YAML → for write methods decode `data` into `options[post_type]` → `new GuzzleHttp\Client()->request(method, url, options)` → wrap response into `DataTransferObject` → `addTokenData(token_name, …)`. Guzzle exceptions are logged and the exception response (if any) is used.

## Action: Convert JSON to List
Decodes a JSON string token into an ECA list token for iteration.

## Condition: Is JSON Data
Returns TRUE when the evaluated value parses as valid JSON; use it to gate steps that consume `contents`.

Security: `access()` returns `AccessResult::allowed()` unconditionally — gate the workflow itself. Because `options` accepts any Guzzle option, a model author can disable TLS (`verify: false`) or set a proxy; the URL is model config, so SSRF exposure equals ECA-model edit trust.
