<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings form & configuration

## Route & menu

- Route `epub_module.epub_settings_form` → `/admin/config/epub/epubsettings`, form `\Drupal\epub_module\Form\EpubConfigForm`, title *E-Book Viewer Configuration Form*, permission `access administration pages`, `_admin_route: TRUE` (`epub_module.routing.yml`).
- Menu link `epub_module.epub_settings_form` (title *EBook Viewer Configuration*, parent `system.admin_config_system`, weight 99) in `epub_module.links.menu.yml`. `data.json` `configure` points here.

## Form

`src/Form/EpubConfigForm.php`, `EpubConfigForm extends ConfigFormBase`.

- `getFormId()` = `epub_config_form`; `getEditableConfigNames()` = `['epub_module.epubsettings']`.
- DI: `config.factory` + `module_handler` (`ModuleHandlerInterface $moduleHandler`).
- `buildForm()` fields (all default from `config('epub_module.epubsettings')`):
  - `background_color` — *Background Color for Epub Viewer*.
  - `icon_color` — *Icon Color for Epub Viewer*.
  - `font_color` — *Font Color for Epub Viewer*.
    - These three use `#type => 'color'` when `moduleHandler->moduleExists('color_field')`, else `#type => 'textfield'`.
  - `show_download_icon` — checkbox *Display Download Icon in Epub Viewer*.
- `submitForm()` saves all four keys to `epub_module.epubsettings` via the config object's `set()->...->save()`.

## Config object

`epub_module.epubsettings` with keys: `background_color`, `icon_color`, `font_color`, `show_download_icon`.

- These are read by `EpubController::viewEbook()` into the reader's `options` (see `api/viewer.md`) and passed to `epub_loader()` / the download-icon toggle in `epub-view.html.twig`.
- **No config schema** (`config/schema/` does not exist) and **no install defaults** (`config/install/` does not exist). Until the form is saved, `get()` on these keys returns `NULL` and the reader falls back to its bundled CSS defaults. The missing schema means core may emit a config-schema warning under strict checking.

## Operate

1. Visit `/admin/config/epub/epubsettings` (needs *access administration pages*).
2. Set colours (hex strings, or via the colour picker if `color_field` is enabled) and toggle the download icon.
3. Save; the reader page reflects the values on next load.
