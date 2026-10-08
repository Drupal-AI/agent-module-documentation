<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# QR URL service plugin type (`qrcode_fields`)

Defines how a QR payload string is turned into an image URL. Swappable per field/block via the
`qrcode_plugin` setting.

## Plugin manager & discovery

- Manager service: `plugin.manager.qrcode_fields` → `QRUrlServicePluginManager`
  (extends `DefaultPluginManager`).
- Discovery namespace: `Plugin/qrcode_fields` (annotation-based).
- Annotation: `@QRUrlServicePlugin(id = "...", label = "...")` (`src/Annotation/QRUrlServicePlugin.php`).
- Interface: `QRUrlServicePluginInterface` — `getUrl(): \Drupal\Core\Url` and
  `getUrlQueryParams(): array`.
- Alter hook: `hook_qrcode_fields_plugin_alter()` (via `alterInfo('qrcode_fields_plugin')`).
- `$manager->getDefinitionsList()` returns `[id => label]` for select options.

## Shipped plugins (`src/Plugin/qrcode_fields/`)

| id | Class | Endpoint | Notes |
|---|---|---|---|
| `goqr` | `QRCodeGenerator` | `https://api.qrserver.com/v1/create-qr-code` | **Default.** `data`, `size=WxH` |
| `tec_it` | `QrCodeTecIt` | `https://qrcode.tec-it.com/API/QRCode` | `data`, `size=W` |
| `gchart` | `GoogleChartAPI` | `https://chart.apis.google.com/chart` | Deprecated Google Chart API; `cht=qr`, `chl`, `chs` |

The `qrcode_fields.qrimage` service also has a private default of `gchart` if `setPlugin()` is not
called, but all fields/blocks call `setPlugin($qrcode_plugin)` (default `goqr`).

## Implement your own

```php
// mymodule/src/Plugin/qrcode_fields/MyQrService.php
namespace Drupal\mymodule\Plugin\qrcode_fields;

use Drupal\Core\Plugin\PluginBase;
use Drupal\Core\Url;
use Drupal\qrcode_fields\QRUrlServicePluginInterface;

/**
 * @QRUrlServicePlugin(
 *   id = "my_qr",
 *   label = "My QR service"
 * )
 */
class MyQrService extends PluginBase implements QRUrlServicePluginInterface {

  public function getUrl() {
    return Url::fromUri('https://qr.example.com/create', ['query' => $this->getUrlQueryParams()]);
  }

  public function getUrlQueryParams() {
    // $this->configuration provides: data, image_width, image_height.
    return [
      'data' => $this->configuration['data'],
      'size' => "{$this->configuration['image_width']}x{$this->configuration['image_height']}",
    ];
  }
}
```

The plugin receives `configuration` = `['data' => <payload>, 'image_width' => int, 'image_height' => int]`
when instantiated by `QRImage::build()`. Return an absolute image URL; it is rendered as
`theme:image`'s `#uri`. To render a QR **without** an external service you would return a data-URI
(e.g. base64-encode a locally generated PNG) from `getUrl()`.
