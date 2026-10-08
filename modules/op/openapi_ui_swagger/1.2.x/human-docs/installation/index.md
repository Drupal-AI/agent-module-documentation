# Installation

Installing Swagger UI for OpenAPI UI has two parts: getting the Drupal modules
in place, and getting the third-party **swagger-ui** JavaScript library onto
disk. The module will not render anything until both are done.

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **OpenAPI UI** module (`drupal/openapi_ui`, `^1`) — the plugin system this
  module extends. Composer pulls it in automatically.
- The **swagger-ui** distribution (`swagger-api/swagger-ui`, `^3.0.17 || ^5.0`)
  installed under your docroot at `libraries/swagger-ui/dist/` (see below).
- To actually see documentation you also need the **OpenAPI** module (which
  provides the docs pages) and at least one *generator* — for example **OpenAPI
  JSON:API** to document your JSON:API resources.

## Install with Composer

From the project root:

```bash
composer require drupal/openapi_ui_swagger -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in the OpenAPI UI dependency.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/openapi_ui_swagger -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

### Getting the swagger-ui library onto disk

The module references the swagger-ui files by an **absolute path** from your
docroot, so the distribution must physically sit at
`<docroot>/libraries/swagger-ui/dist/`. There is no status-report warning if it
is missing — you simply get a blank docs page — so it is worth confirming the
files are there:

```bash
ls web/libraries/swagger-ui/dist/swagger-ui-bundle.js
```

You can get the library there in one of two ways:

- **With Composer** (recommended). Make Composer place the library into
  `web/libraries` by adding the custom-directory installers and an installer
  path:

  ```bash
  composer require composer/installers mnsami/composer-custom-directory-installer
  ```

  Then in `composer.json`, under `extra.installer-paths`, map the library:

  ```json
  "web/libraries/{$name}": ["swagger-api/swagger-ui", "type:drupal-library"]
  ```

  With that in place, the `swagger-api/swagger-ui` package required by the module
  is installed into `web/libraries/swagger-ui` automatically.

- **Manually** (for non-Composer sites). Download a swagger-ui release and unzip
  it into `<docroot>/libraries/swagger-ui` so that the `dist/` folder ends up at
  `libraries/swagger-ui/dist/`.

## Enable the module

```bash
drush en openapi_ui_swagger -y
```

Enabling this module also enables its **OpenAPI UI** dependency. To see any
documentation, make sure the **OpenAPI** module and a generator (such as
**OpenAPI JSON:API**) are enabled too, and grant the **Access OpenAPI api docs**
permission to the roles that should see the docs:

```bash
drush role:perm:add api_consumer 'access openapi api docs'
```

## Verify it worked

Go to **Configuration → Web services → OpenAPI**
(`/admin/config/services/openapi`). You should see the available documentation
listed. Open the Swagger UI version of one of them — for example
`/admin/config/services/openapi/swagger/jsonapi` — and the interactive Swagger
UI explorer should render. If the page is blank, re-check that the swagger-ui
library files exist under `web/libraries/swagger-ui/dist/`.
