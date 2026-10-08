<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration: settings form, explorer, routes & permissions

## Permission (`document_loader.permissions.yml`)

- `document_loader.administer` — "Administer document loader settings". Gates both routes below.
  (The Tool submodule adds its own `use document_loader tool` permission — see that submodule's
  docs.)

## Routes (`document_loader.routing.yml`)

- `document_loader.settings_form` — `/admin/config/media/document-loader`, form
  `Form\DocumentLoaderSettingsForm`, `_permission: document_loader.administer`. This is the
  `configure` route in `document_loader.info.yml`.
- `document_loader.explorer_form` — `/admin/config/media/document-loader/explorer`, form
  `Form\DocumentLoaderExplorerForm`, same permission. A test bench to run a load and view the
  result.

Menu link `document_loader.settings` under *Configuration → Media*
(`document_loader.links.menu.yml`); local tasks "Settings" / "Explorer"
(`document_loader.links.task.yml`).

## Settings form

`Form\DocumentLoaderSettingsForm` writes the single config object **`document_loader.settings`**.
It lets an administrator pick, per document type (and optionally per output format), which loader
plugin is the default. Values are stored in the `default_loaders` map (flat keys `"{type}"` or
`"{type}.{output}"`), read back by `DocumentLoaderManager::getDefaultLoader()`. Programmatic
equivalent: `DocumentLoaderManager::setDefaultLoader($type, $plugin_id, ?$output_type)`.

If no loader modules are installed there are no loaders to choose and every load fails with
`DocumentLoaderNotFoundException`.

## Config object & schema

- Object: `document_loader.settings`.
- Schema (`config/schema/document_loader.schema.yml`): `default_loaders` is typed **`ignore`**
  (an open map keyed by type/type.output → loader plugin ID), so strict config-schema tooling will
  not validate its contents.

```yaml
# document_loader.settings
default_loaders:
  'document_loader_type:pdf': 'my_pdf_loader'
  'document_loader_type:website.markdown': 'my_web_loader'
```

## Help hook

`Hook\DocumentLoaderHooks::help()` (attribute `#[Hook('help')]`, bridged from
`document_loader.module`) returns help text for `help.page.document_loader` and the settings-form
route.

## Library

`explorer_form` (`document_loader.libraries.yml`) — CSS `css/document_loader.explorer_form.css`,
depends on `core/drupal`. No external/CDN assets.
