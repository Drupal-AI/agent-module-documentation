<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Auphonic API client (`auphonic.api`)

`Drupal\auphonic\AuphonicApi` — a thin Guzzle wrapper over the Auphonic REST API. Service id
**`auphonic.api`** (`auphonic.services.yml`), constructor args `@http_client`, `@config.factory`,
`@key.repository`.

## Construction & auth

- Base host is a fixed private property: **`https://auphonic.com/api/`** (`$baseHost`). All requests go
  here over HTTPS.
- On construct it reads `provider_auphonic.settings`: `username` (plain), and `password` = a Key id, which
  it resolves to the secret via `$keyRepository->getKey($password)->getKeyValue()`.
- `setUsername($u)` / `setPassword($p)` override the credentials at runtime (used by
  `AuphonicProvider::setAuthentication()`), letting a caller pass a literal password instead of a Key.

## `makeRequest()` (protected, the core)

`makeRequest($path, array $query_string = [], $method = 'GET', $body = '', array $options = [])`:

- Throws `\Exception('No username or password set.')` if either credential is empty.
- Sets `connect_timeout`, `read_timeout`, `timeout` all to **30s**.
- Sets `$options['auth'] = [$this->username, $this->password]` → HTTP **Basic** auth.
- If `$body` is truthy: sets `content-type: application/json` and `body = json_encode($body)`.
- Builds the URL as `rtrim($baseHost,'/') . '/' . $path` plus `?http_build_query($query_string)`.
- Calls `$this->client->request($method, $new_url, $options)` and returns the Guzzle response
  (default TLS verification).

## Public methods

| Method | Auphonic endpoint | Behavior |
|---|---|---|
| `startSimpleProduction($file, $options=[])` | `POST simple/productions.json` | Multipart upload of `$file` (`input_file`) plus `action=start` and any `$options` (arrays expanded to repeated fields). Returns decoded JSON. |
| `startProduction($file, $preset, $title, $options=[])` | `POST productions.json` → `POST production/{uuid}/upload.json` → `POST production/{uuid}/start.json` | Creates a production with `preset` + `metadata.title`, requires `data.uuid` (else throws), multipart-uploads the file (throws if `status_code != 200`), then starts it. Returns the start response. |
| `getProduction($uuid)` | `GET production/{uuid}.json` | Decoded JSON production status. |
| `getPresets()` | `GET presets.json` | Decoded JSON list of presets. |
| `downloadProductionFromUuid($uuid, $destination='')` | (`GET production/{uuid}.json` then download) | Reads `data.output_files[0].download_url` (throws if missing) and downloads it. |
| `downloadProduction($url, $destination='')` | `GET {url}` | Strips `$baseHost` from `$url`, then `makeRequest()` re-prepends it — so downloads always resolve against `auphonic.com`. If `$destination` is set, streams to it via Guzzle `sink`. Returns the response object. |

## Usage sketch

```php
/** @var \Drupal\auphonic\AuphonicApi $api */
$api = \Drupal::service('auphonic.api');
$presets = $api->getPresets();                 // list models
$start = $api->startProduction($file, $presetUuid, 'My title');
$uuid  = $start['data']['uuid'];
do { sleep(5); $p = $api->getProduction($uuid); } while ($p['data']['status'] != 3);
$response = $api->downloadProduction($p['data']['output_files'][0]['download_url']);
$binary = $response->getBody()->getContents();
```

Auphonic production `status == 3` means "Done". Callers poll for it (the provider caps at 20 tries × 5s).
