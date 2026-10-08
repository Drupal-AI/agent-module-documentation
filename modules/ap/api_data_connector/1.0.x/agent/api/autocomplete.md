<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Autocomplete route & controller

The default and tags widgets drive their suggestions through one route; the Select2 widget does
its own fetch at form-build (see [../fields/field.md](../fields/field.md)) and does **not** use
this route.

## Route

`api_data_connector.routing.yml`:

```
api_data_connector.autocomplete:
  path: '/api-data-connector/individual-user/autocomplete'
  defaults:
    _controller: '\Drupal\api_data_connector\Controller\ApiDataConnectorController::autocomplete'
    _title: 'Autocomplete'
  requirements:
    _permission: 'access content'
```

It is a plain **GET** endpoint, gated only by the core `access content` permission. There is no
`_csrf_token`, and no per-field or per-entity check — it is a generic proxy keyed entirely off its
query string.

## Controller — `ApiDataConnectorController::autocomplete()`

`src/Controller/ApiDataConnectorController.php`. Injected services (via `create()`):
`config.factory`, `http_client` (Guzzle), and `logger.factory->get('api_data_connector')`.

Reads five query-string values from the `Request`:

| Query param | Used as |
|---|---|
| `q` | the typed text (`$input`) |
| `api_url` | the endpoint to GET |
| `query` | the name of the query parameter the typed text is sent under |
| `key` | response field read as the suggestion **id** |
| `value` | response field read as the suggestion **label** |

Flow when both `q` and `api_url` are present:

1. Builds `$queryParams = [ $query => $input ]`.
2. `$this->httpClient->request('GET', $api_url, ['query' => $queryParams])` — a Guzzle GET (default
   TLS verification applies).
3. `json_decode(...->getBody()->getContents(), TRUE)` and iterates the rows; for each row with both
   `$row[$key]` and `$row[$value]` set, appends `['value' => "<value>(<key>),", 'label' => "<value>"]`.
4. On any exception, logs `Failed to fetch user options from API: @message` and returns whatever
   options were collected.

Returns a `JsonResponse` of the `value`/`label` array. Core's autocomplete JS renders each `label`
and inserts the `value` (`Name(id),`) into the text field; the widget's `massageFormValues()` later
extracts the `(id)` and name (see the widget doc).

## Notes

- The `value` string embeds the raw label plus `(<id>),` — the widget relies on that exact shape to
  parse selections back out.
- The controller injects `config.factory` but does not use it.
- The Select2 widget path (`fetchSelectOptions()`) hits the API server-side at form build instead,
  and serializes the whole matched row into the option key.
