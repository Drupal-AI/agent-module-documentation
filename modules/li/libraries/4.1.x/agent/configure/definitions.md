# Configure definition discovery

No admin UI. Behavior is driven by the `libraries.settings` config (schema
`config/schema/libraries.schema.yml`, defaults `config/install/libraries.settings.yml`):

```yaml
definition:
  local:
    path: 'public://library-definitions'   # where fetched JSON defs are stored
  remote:
    enable: true                            # set false to disable remote fetching
    urls:
      - 'http://cgit.drupalcode.org/libraries_registry/plain/registry/8'
global_locators: []                         # locator plugin IDs applied to every library
```

- By default definitions are downloaded from the remote **libraries registry** and cached under
  `public://library-definitions` (`library-definitions://`). Set `definition.remote.enable: false`
  to manage definitions yourself; add/replace `urls` to point at a custom registry.
- To use **version-controlled local YAML** instead of remote JSON, override the
  `libraries.definition.discovery` service in your site `services.yml`:
  ```yaml
  libraries.definition.discovery:
    class: Drupal\libraries\ExternalLibrary\Definition\FileDefinitionDiscovery
    arguments: ['@serialization.yaml', '../library-definitions']
  ```
- `global_locators` lists locator plugin IDs tried for every library (e.g. a global filesystem
  path). `LibrariesConfigSubscriber` reacts to config changes.
- Extensions request libraries with `library_dependencies:` in their `.info.yml` (array of
  library machine names) — no config needed on the library module side.
