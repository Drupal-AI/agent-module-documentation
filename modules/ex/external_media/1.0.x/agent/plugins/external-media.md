# Plugin type: `ExternalMedia` (add a provider)

External Media defines one plugin type. Each plugin is a service you can pick files
from. Adding a service = adding a plugin; no core patching.

| Piece | Value |
|---|---|
| Manager service | `plugin.manager.external_media` (`Plugin\ExternalMediaManager`) |
| Plugin directory | `Plugin/ExternalMedia/` (in any module) |
| Attribute | `Drupal\external_media\Attribute\ExternalMedia` (D11+) |
| Annotation (legacy) | `Drupal\external_media\Annotation\ExternalMedia` |
| Interface | `Drupal\external_media\Plugin\ExternalMediaInterface` |
| Base class | `Drupal\external_media\Plugin\ExternalMediaBase` |
| Alter hook | `external_media_plugin_info` |
| Cache | tag `emw:<plugin_id>`, cache key `external_media_plugin` |

## Attribute properties

`#[ExternalMedia(id, name, description, module, css_class, icon, website, deriver)]`
— `id` required; `name`/`description` are `TranslatableMarkup`; `css_class` is the CSS
class put on the button (and matched by the provider JS to bind the picker); `icon` is
a file name under the module's `img/` dir; `module` names the owning module (used by
`hook_library_info_build` to register the plugin's JS library).

## Key methods (override on `ExternalMediaBase`)

| Method | Purpose |
|---|---|
| `classExists()` | Return FALSE to hide the plugin (no permission, not in fields) when its SDK is unavailable. Default TRUE. |
| `getLibraries()` | The Drupal library array (vendor JS + local JS) registered as `<module>.<plugin_id>`. |
| `getAttachments()` | `#attached` (libraries + `drupalSettings`) added to the widget when this service is shown. |
| `configForm()` / `submitConfigForm()` | Provider settings on the admin form; persist with `setSetting()`. |
| `setAttributes($info)` | `data-*` attributes on the button (`plugin`, `cardinality`, `description`, `max-filesize`, `file-extentions`, `multiselect`) read by the JS picker. |
| `getFile($url, $destination)` | Turn the picker's return value into a fetch instruction. Return `['source' => $downloadUrl, 'destination' => $uri]` **or** `['source_data' => $bytes, 'destination' => $uri]`, or nothing to skip. **Base returns `['source' => $url, ...]` unconstrained — override it and validate the URL/host** (all bundled providers do). |
| `renderInline()` / `renderPopupContents()` | Optional extra markup / a popup viewer served through `external_media.redirect_callback`. |
| `setRedirectCallback()` | Return non-empty (usually `getLibraries()`) if the service needs the OAuth redirect route; makes the settings form show the Redirect URL. |

`ExternalMediaBase` also provides settings helpers (`getSetting`/`setSetting`, State
key `external_media.info`), `getStorage`/`setStorage` (private tempstore), and
`getRedirectUrl()` (route `external_media.redirect_callback`).

## Minimal skeleton

```php
namespace Drupal\my_module\Plugin\ExternalMedia;

use Drupal\Core\StringTranslation\TranslatableMarkup;
use Drupal\external_media\Attribute\ExternalMedia;
use Drupal\external_media\Plugin\ExternalMediaBase;

#[ExternalMedia(
  id: 'my_service',
  name: new TranslatableMarkup('My Service'),
  description: new TranslatableMarkup('Pick files from My Service'),
  css_class: 'my-service-picker',
  module: 'my_module',
)]
class MyService extends ExternalMediaBase {
  public function getLibraries() { return ['js' => ['js/my-service.js' => []], 'dependencies' => ['core/drupalSettings']]; }
  public function getAttachments() { return ['library' => ['my_module/my_module.my_service']]; }
  public function getFile($url, $destination) {
    // Validate the host before returning a source to fetch.
    if (str_starts_with($url, 'https://files.my-service.example/')) {
      return ['source' => $url, 'destination' => $destination];
    }
  }
}
```

The plugin then generates the permission `upload from my_service`, a settings tab, and
a widget button automatically.
