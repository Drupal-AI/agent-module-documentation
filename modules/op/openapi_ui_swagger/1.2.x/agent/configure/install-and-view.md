<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Installing the library and viewing the docs

The module itself has **nothing to configure** — no settings form, no `configure` key, no
config schema. All the setup is (a) getting the swagger-ui distribution on disk and (b)
knowing the URL.

## 1. The swagger-ui library

`openapi_ui_swagger.libraries.yml` declares:

```yaml
swagger_ui:
  js:
    /libraries/swagger-ui/dist/swagger-ui-bundle.js: {}
    /libraries/swagger-ui/dist/swagger-ui-standalone-preset.js: {}
  css:
    theme:
      /libraries/swagger-ui/dist/swagger-ui.css: { minified: true }
swagger_ui_integration:
  js: { js/swagger.js: {} }
  dependencies: [core/jquery, core/drupal, openapi_ui_swagger/swagger_ui]
```

Paths are absolute from the **docroot**, so the files must exist at
`<docroot>/libraries/swagger-ui/dist/…`. There is no `hook_requirements()` — if the library
is missing you get an empty page (and `file_get_contents(libraries/swagger-ui/...)` warnings
in the log), not a status-report error. Check with:

```bash
ls web/libraries/swagger-ui/dist/swagger-ui-bundle.js
```

Composer route (`swagger-api/swagger-ui` is in the module's `require`):

```bash
composer require composer/installers mnsami/composer-custom-directory-installer
# composer.json → extra.installer-paths:
#   "web/libraries/{$name}": ["swagger-api/swagger-ui", "type:drupal-library"]
composer require drupal/openapi_ui_swagger
```

Manual route: download a swagger-ui release and unzip it to `<docroot>/libraries/swagger-ui`.

## 2. Where the docs page lives

`openapi_ui_swagger` defines no routes. The browsable page comes from the **`openapi`**
module:

| Route | Path |
|---|---|
| `openapi.downloads` | `/admin/config/services/openapi` — list of available docs |
| `openapi.documentation` | `/admin/config/services/openapi/{openapi_ui}/{openapi_generator}` |
| `openapi.download` | `/openapi/{openapi_generator}` — the raw JSON spec |

`{openapi_ui}` is this module's plugin id, **`swagger`** (a param converter turns it into the
plugin instance). `{openapi_generator}` comes from whatever generator modules are enabled,
e.g. `jsonapi` from `openapi_jsonapi`. So the typical URL is:

```
/admin/config/services/openapi/swagger/jsonapi
```

Both routes require openapi's permission **`access openapi api docs`**:

```bash
drush role:perm:add api_consumer 'access openapi api docs'
```

## 3. Checking what is available

```bash
# is the swagger plugin registered?
drush php:eval 'print implode(",", array_keys(\Drupal::service("plugin.manager.openapi_ui.ui")->getDefinitions()));'
# → redoc,swagger   (redoc only if openapi_ui_redoc is installed)
```

Switching the docs page to ReDoc is just swapping `swagger` for `redoc` in the URL — nothing
in config records a "current" UI.
