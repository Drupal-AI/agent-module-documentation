<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Viewer route, controller & bundled reader

## Route

`epub_module.routing.yml`:

```
epub_module.epub:
  path: '/view-ebook/{fid}'
  defaults: { _controller: '\Drupal\epub_module\Controller\EpubController::viewEbook', _title: 'EPUB Viewer' }
  requirements: { _permission: 'access content' }
```

`{fid}` is a file entity id. The formatter (`fields/formatter.md`) links here.

## Controller

`src/Controller/EpubController.php`, `EpubController extends ControllerBase`.

- DI (`create()`): `file_url_generator` (`FileUrlGeneratorInterface $fileUrl`), `extension.list.module` (`ModuleExtensionList $listModule`), `renderer` (`RendererInterface $renderer`), `config.factory` (`ConfigFactory $config`). Also uses `entityTypeManager()` from `ControllerBase`.
- `viewEbook($fid = FALSE)`:
  1. Loads the file: `entityTypeManager()->getStorage('file')->load($fid)`.
  2. `$file_uri = $file->getFileUri()`; `$file_url = Url::fromUri($this->fileUrl->generateAbsoluteString($file_uri))`.
  3. Builds `$data` = `file_path` (absolute file URL), `base_url` (global `$base_url`), `module_path` (`$base_url . '/' . extension.list.module->getPath('epub_module')`).
  4. Reads config `epub_module.epubsettings` into `$options` = `background_color`, `icon_color`, `font_color`, `show_download_icon`.
  5. Renders `['#theme' => 'epub_view', '#data' => $data, '#options' => $options]` via `renderer->renderRoot()` and returns a raw `Symfony\...\Response` with that HTML (a full standalone HTML document, not a themed page).

## Theme & template

`hook_theme()` (`epub_module.module`) registers `epub_view` (vars `data`, `options`). `templates/epub-view.html.twig` is a complete `<html>` document that:

- Loads bundled CSS/JS from `{{ data.module_path }}` (`css/main1.css`, `normalize.css`, `popup.css`, jQuery UI CSS, themify-icons) and scripts `js/epub.js`, `js/jszip.min.js`, `js/screenfull.min.js`, `js/content_view.js`, jQuery UI JS.
- Also loads two **CDN** scripts: jQuery 3.4.1 from `ajax.googleapis.com` and `jquery.detect_swipe` 2.1.1 from `cdnjs.cloudflare.com`.
- Emits an inline `<script>` that builds `epub_settings = { site_url, file_path, icon_color, font_color, background_color }` from the Twig vars and calls `epub_loader(epub_settings)` (defined in `js/content_view.js`).
- Optionally shows a download anchor (`href="{{ data.file_path }}"`) when `options.show_download_icon` is set, plus a home link and a chapter/TOC sidebar; the reader renders into `#viewer`.

## Not the Drupal library system

There is **no** `epub_module.libraries.yml`. The reader's assets are pulled in by hard-coded `<link>`/`<script>` tags in the template, keyed off `module_path`. `templates/epub-light-theme-view.html.twig` exists but is **unused** — no theme hook maps to it and it `attach_library('epub_module/epub-style')`, a library that is not defined.

## Operate

- The link is produced by the formatter; visiting `/view-ebook/{fid}` renders the reader for that file id.
- Colours/download-icon come from `epub_module.epubsettings` (see `config/settings.md`); with no saved config the option values are empty/null and the reader uses its own CSS defaults.
