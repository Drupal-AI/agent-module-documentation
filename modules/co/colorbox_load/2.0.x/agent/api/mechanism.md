<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How Colorbox Load works (and how to reuse it)

Three files do everything: `colorbox_load.services.yml`, `src/Renderer.php`,
`src/OpenCommand.php` (+ 12 lines of JS).

## The chain

1. **NG Lightbox rewrites the link.** `ng_lightbox_link_alter()` matches the link's path
   against `ng_lightbox.settings:patterns` (internal path *and* alias) and, on a match, adds
   `class="use-ajax"` plus
   `data-dialog-type = str_replace('drupal_', '', renderer)` → `colorbox`, and
   `data-dialog-options = {"width": default_width, "dialogClass": lightbox_class}`.
2. **Drupal picks the renderer by wrapper format.** `core/drupal.ajax` sends
   `?_wrapper_format=drupal_colorbox`. The service below is tagged with that format:

   ```yaml
   # colorbox_load.services.yml
   services:
     colorbox_load.renderer:
       class: Drupal\colorbox_load\Renderer
       arguments: ['@renderer']
       tags:
         - { name: render.main_content_renderer, format: drupal_colorbox, ng_lightbox: Colorbox }
   ```

   The extra `ng_lightbox: Colorbox` attribute is what makes it show up in NG Lightbox's
   *Renderer* select (NG Lightbox's compiler pass `NgLightboxPass` collects it into the
   `ng_lightbox_renderers` container parameter).
3. **`Drupal\colorbox_load\Renderer::renderResponse()`** renders the main content with
   `RendererInterface::renderInIsolation()`, copies `#attached` onto an `AjaxResponse`, and
   adds one command: `new OpenCommand($html)`.
4. **`OpenCommand::render()`** emits `['command' => 'colorboxLoadOpen', 'data' => $html]`.
5. **`js/colorbox_load.js`** implements `Drupal.AjaxCommands.prototype.colorboxLoadOpen`:

   ```js
   $.colorbox($.extend({}, drupalSettings.colorbox, {
     html: response.data, width: '90%', height: '90%'
   }));
   Drupal.attachBehaviors();
   ```

   Note: **width/height are hard-coded to 90%** here, so NG Lightbox's `default_width` is
   *not* honoured by the Colorbox renderer (it is only written into the link attribute).
   Other Colorbox options come from `drupalSettings.colorbox`, i.e. the Colorbox module's
   own settings form.

`colorbox_load_page_attachments()` attaches the Colorbox library on every page (via
`\Drupal::service('colorbox.attachment')->attach($page)`) plus the
`colorbox_load/colorbox_load` library, so the command is always available.

## Calling it from your own code

`OpenCommand` is a plain `CommandInterface` — return it from any controller or form AJAX
callback to open arbitrary rendered markup in Colorbox:

```php
use Drupal\colorbox_load\OpenCommand;
use Drupal\Core\Ajax\AjaxResponse;

$response = new AjaxResponse();
$html = \Drupal::service('renderer')->renderInIsolation($build);
$response->addCommand(new OpenCommand($html));
return $response;
```

The page must have the `colorbox_load/colorbox_load` library attached (it is, on every page,
while the module is enabled).

## Things that surprise people

- There is **no `colorbox_load` config object**; `drush cget colorbox_load.settings` fails.
  All state is in `ng_lightbox.settings`.
- Uninstalling the module sets `ng_lightbox.settings:renderer` to NULL, which makes
  NG Lightbox fall back to `NgLightbox::DEFAULT_MODAL` (`drupal_modal`).
- Because it is a normal `<a href>` with `use-ajax`, crawlers and "open in new tab" get the
  ordinary full page — the behaviour degrades gracefully by design.
- `renderInIsolation()` means the lightboxed page is rendered without the outer page's
  render context; blocks/regions of the theme are not included, only the main content.
