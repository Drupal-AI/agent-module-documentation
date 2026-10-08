# Servers and calls (the endpoint config)

An integration is two config entities: a **WSServer** (endpoint + connector) and one or more
**WSCall** (server + decoder/encoder + connector options). Both are `ConfigEntityBase`, so they
export with the site.

## WSServer (`wsserver`, prefix `wsdata.wsserver.*`)

Admin UI: `/admin/structure/wsserver` (collection), add/edit/delete forms. Admin permission
`administer site configuration`. Form `\Drupal\wsdata\Form\WSServerForm`.

Exported keys (`config_export`): `id`, `label`, `endpoint`, `wsconnector`,
`languagehandling`, `settings`.

| Key | Meaning |
|---|---|
| `endpoint` | Base URL (or base path, for the local-file connector). Required. Trimmed. |
| `wsconnector` | Connector plugin id, e.g. `WSConnectorSimpleHTTP`. |
| `languagehandling` / `settings` | Structs, mostly unused at server level in 3.0.x. |

## WSCall (`wscall`, prefix `wsdata.wscall.*`)

Admin UI: `/admin/structure/wscall` (collection). Form `\Drupal\wsdata\Form\WSCallForm`.
The **canonical** route `/admin/structure/wscall/{wscall}` is the built-in **test** form
(`WSCallTestForm`): pick replacement values, click *Call*, see the raw response.

Exported keys: `id`, `label`, `wsserver`, `wsdecoder`, `wsencoder`, `options`.

| Key | Meaning |
|---|---|
| `wsserver` | The `wsserver` id this call uses. |
| `wsdecoder` | Decoder plugin id (`WSDecoderJSON`, `WSDecoderXML`, `WSDecoderString`, …). |
| `wsencoder` | Encoder plugin id for the request body (`WSEncoderJSON`, `WSEncoderString`). |
| `options` | Per-connector options keyed by server id: `options[<wsserver_id>] = [...]`. Built by the connector's `saveOptions()`. |

`options` for the HTTP connector: `path` (appended to the endpoint as `endpoint/path`),
`method` (get/post/…), `expires` (cache TTL override, seconds), `skip_verify_ssl`, and a list of
request `headers` (key/value). SOAP adds `user`, `key` (password), `wsdl`, `method`; GraphQL
adds `query`, `operationName`, `variables`; local file adds `filename`, `readonly`.

## Routes

| Route name | Path | Purpose |
|---|---|---|
| `entity.wsserver.collection` | `/admin/structure/wsserver` | List servers |
| `entity.wsserver.add_form` / `.edit_form` / `.delete_form` | `/admin/structure/wsserver/…` | CRUD |
| `entity.wscall.collection` | `/admin/structure/wscall` | List calls |
| `entity.wscall.canonical` | `/admin/structure/wscall/{wscall}` | **Test** form |
| `entity.wscall.add_form` / `.edit_form` / `.delete_form` | `/admin/structure/wscall/…` | CRUD |
| `wsdata.settings` | `/admin/config/services/wsdata` | Global settings |

All gated by `administer site configuration`.

## Create via config (PHP)

```php
\Drupal\wsdata\Entity\WSServer::create([
  'id' => 'jsonplaceholder',
  'label' => 'JSONPlaceholder',
  'endpoint' => 'https://jsonplaceholder.typicode.com',
  'wsconnector' => 'WSConnectorSimpleHTTP',
])->save();

$call = \Drupal\wsdata\Entity\WSCall::create([
  'id' => 'fetch_post',
  'label' => 'Fetch a post',
  'wsserver' => 'jsonplaceholder',
  'wsdecoder' => 'WSDecoderJSON',
  'wsencoder' => 'WSEncoderString',
]);
// Per-connector options are stored under the server id.
$call->options = ['jsonplaceholder' => ['path' => 'posts/[id]', 'method' => 'get']];
$call->save();
```

The `[id]` token in the path is a **replacement**: `WSCall::getReplacements()` scans
`endpoint/path` for `[name]` patterns, and callers supply values (see
[../api/service.md](../api/service.md)). Endpoint and path come from this admin-authored config;
replacement values come from the caller (field/block config or Drupal core tokens).

## Config-install example

`wsdata_example` ships `wsdata.wsserver.example_server.yml`,
`wsdata.wscall.fetch_all_post.yml` and `wsdata.wscall.fetch_individual_post.yml` — copy those as
templates.
