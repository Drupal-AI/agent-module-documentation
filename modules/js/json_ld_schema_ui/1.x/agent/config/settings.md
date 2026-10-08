<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Site settings & schema.org fetch/parse

Files: `json_ld_schema_ui.routing.yml`, `src/Form/SchemaSettingsConfigForm.php`,
`config/install/json_ld_schema_ui.settings.yml`, `config/schema/json_ld_schema_ui.schema.yml`,
`src/Schemaorg/*` (`RemoteFetcher`, `Parser`, `SchemaData`), `src/Config/SchemaConfigSubscriber.php`.

## Config object `json_ld_schema_ui.settings`

Install defaults:

```yaml
schema:
  base_uri: https://schema.org
  sources:
    - https://schema.org/version/latest/schemaorg-current-https.jsonld
```

Schema (`config/schema`): `schema.base_uri` (`uri`), `schema.sources` (sequence of `string`).
`base_uri` becomes the JSON-LD `@context`; `sources` are the schema.org vocabulary URLs the parser
fetches.

## Settings form & route

- Route `json_ld_schema_ui.settings` → `/admin/config/search/schemaorg/settings`, form
  `SchemaSettingsConfigForm` (extends `ConfigFormBase`), perm **`administer content schema
  settings`**. Menu link under *Configuration → Search and metadata* (`*.links.menu.yml`); this is
  also the module's `configure` route.
- In 1.0.6 the form is effectively locked to schema.org: the "Sources" textfield is `#disabled` with
  a fixed default, and `submitForm()` always writes `base_uri => https://schema.org` and
  `sources => [https://schema.org/version/latest/schemaorg-current-https.jsonld]` regardless of
  input (the description notes schema.org keeps changing its versioned data, so it is pinned to
  latest). The README warns the settings are "not properly validated."
- `SchemaConfigSubscriber` subscribes to `ConfigEvents::SAVE`; on a change to
  `json_ld_schema_ui.settings`'s `schema` key it is meant to clear the stored parsed schema — but
  the clear body is currently a `@todo` no-op.

## Schema.org fetch/parse services

- `json_ld_schema_ui.schemaorg.fetcher` — **`RemoteFetcher`** (`@config.factory`, `@http_client`).
  `fetch()` reads `schema.sources` and does a Guzzle `GET` per source, yielding the body. Throws
  `FetchException` on Guzzle errors or when config is not yet installed. (Because the source URL is
  the pinned schema.org endpoint and is only reachable via admin-only config, this is not a
  user-supplied fetch.)
- `json_ld_schema_ui.schemaorg.parser` — **`Parser`** — parses the fetched JSON-LD vocabulary into
  graph nodes (`src/Schemaorg/GraphNode/*`: `Type`, `Property`, `PropertyOption`, `DataType`).
- `json_ld_schema_ui.schema` — **`SchemaData`** — the façade the forms/widget use:
  `getRootId()`, `getSchemaLabel()/getSchemaId()`, `getDescendantPaths()`, `getProperties()`,
  `getPropertyValues()`, `getEnumOptions()`. It builds label↔id maps from the parsed vocabulary on
  construction.

These services are consumed by `EntitySchemaConfigurationForm`, `EntitySchemaAddPropertyForm`, and
`JsonLdDefaultWidget` to populate type/property pickers and enum options — they do not run on the
front-end render path (that path only reads stored config + tokens; see
[../fields/jsonld.md](../fields/jsonld.md)).

## Notes

- No Drush commands, no cron, no queue.
- Changing `base_uri` changes the emitted `@context` value for all output.
- The vocabulary fetch happens when an admin builds a bundle mapping; on large sites cache the parsed
  result (state) as intended — note the config-change cache clear is currently a `@todo`.
