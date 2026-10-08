<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Web Service Data (wsdata) — agent index

Turns an external web service (REST/HTTP, SOAP, GraphQL, local file) into reusable
**configuration**, not code. You define a **WSServer** (endpoint + transport connector) and a
**WSCall** (which server, which decoder/encoder, per-call options), then read the decoded
response from PHP, a block, or an entity field. Responses are cached in a dedicated `wsdata`
cache bin.

- No required dependencies; core `^9 || ^10 || ^11`. Package `WSData`.
- Settings page: `/admin/config/services/wsdata` (route `wsdata.settings`, permission
  `administer site configuration`).
- Defines **3 plugin types** (WSConnector, WSEncoder, WSDecoder), **2 config entities**
  (`wsserver`, `wscall`), a service (`wsdata`), and a cache bin (`wsdata`).
- No permissions.yml, no drush commands. Provides config schema.

## Solution docs

- **Global settings (debug / performance log)** → [configure/settings.md](configure/settings.md)
- **Create a server + call (the endpoint config), routes, per-connector options** → [configure/servers-and-calls.md](configure/servers-and-calls.md)
- **Call a service from PHP; the fetch/cache flow and call status** → [api/service.md](api/service.md)
- **The connector / decoder / encoder plugin types + how to add one** → [plugins/plugin-types.md](plugins/plugin-types.md)
- **Render a call as a block** (submodule `wsdata_block`) → [blocks/wsdata-block.md](blocks/wsdata-block.md)
- **Expose a call as an entity field** (submodule `wsdata_field`) → [fields/wsdata-field.md](fields/wsdata-field.md)

## Submodules

| Submodule | Purpose |
|---|---|
| `wsdata_block` | Block plugin that renders a WSCall result. |
| `wsdata_field` | Web-service-backed field storage (custom-storage field + `wsfield_config`). |
| `wsdata_extras` | Extra decoders (`WSDecoderJSONList`). |
| `wsdata_example` | Worked example (server, calls, node type, block decoder). Read this first. |

## Key facts

- Config entities: `wsserver` (config prefix `wsdata.wsserver.*`), `wscall`
  (`wsdata.wscall.*`); admin_permission `administer site configuration`.
- Service id `wsdata` → `\Drupal\wsdata\WSDataService`; main method `call()`.
- Plugin managers: `plugin.manager.wsconnector`, `plugin.manager.wsencoder`,
  `plugin.manager.wsdecoder`. Annotations `@WSConnector` / `@WSEncoder` / `@WSDecoder`.
  Alter hooks `wsdata_wsconnector_info`, `wsdata_wsencoder_info`, `wsdata_wsdecoder_info`.
- Built-in connectors: `WSConnectorSimpleHTTP`, `WSConnectorSimpleHTTPWithLangReplacement`,
  `WSConnectorGraphQL`, `WSConnectorSOAP`, `WSConnectorLocalFile`.
- Built-in decoders: `WSDecoderJSON`, `WSDecoderXML`, `WSDecoderString`
  (+ `WSDecoderJSONList` from `wsdata_extras`). Encoders: `WSEncoderJSON`, `WSEncoderString`.
- State keys: `wsdata_debug_mode`, `wsdata_performance_log`, and per-server
  `wsdata.wsserver.<id>` (endpoint override / degraded backoff).
- Response cache bin: `wsdata` (`cache.wsdata`).
- Entity routes: `/admin/structure/wsserver`, `/admin/structure/wscall`
  (add/edit/delete + a `test` form on the WSCall canonical route).
