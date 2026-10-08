# Akamai plugin types & plugins

## `akamai_client` plugin type (this module defines it)

- Manager: `akamai.client.manager` (`AkamaiClientManager`, extends `default_plugin_manager`).
- Annotation: `@AkamaiClient` (`src/Annotation/AkamaiClient.php`), directory `src/Plugin/Client/`.
- Resolved through `akamai.client.factory` (`AkamaiClientFactory`), which reads
  `akamai.settings:version` to pick the active client.
- Shipped plugin: **`v3`** → `AkamaiClientV3` (title "Akamai CCU v3", extends `AkamaiClientBase`)
  — the Fast Purge / CCUv3 REST client. To add a new CCU version, add a class in
  `src/Plugin/Client/` with `@AkamaiClient(id="…")` and implement `AkamaiClientInterface`.

Each client contributes its own sub-settings form (`buildConfigurationForm`) merged into the
main config form under a details element per version.

## Purge integration plugins (require the `purge` module)

These are consumed by the Purge framework, not defined types here:

- **`akamai`** — `src/Plugin/Purge/Purger/AkamaiPurger.php`: purges by URL / full path.
- **`akamai_tag`** — `src/Plugin/Purge/Purger/AkamaiTagPurger.php`: purges by cache tag
  (pairs with the `Edge-Cache-Tag` header).
- **`QueueLengthCheck`** / **`CredentialCheck`** — `src/Plugin/Purge/DiagnosticCheck/`:
  Purge diagnostics that warn on a long queue or missing/invalid credentials.

## Block plugin

- **`CacheClearBlock`** (`src/Plugin/Block/CacheClearBlock.php`) — the "Akamai Cache Clear"
  block that clears the currently viewed page; gated by `purge akamai cache`.
