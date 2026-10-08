<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# qr_block — add a QR generator plugin

QR services are `QRUrlServicePlugin` plugins under `src/Plugin/qr_block/`, managed by `plugin.manager.qr_block`.

```php
namespace Drupal\my_module\Plugin\qr_block;

use Drupal\Core\Plugin\PluginBase;
use Drupal\Core\Url;
use Drupal\qr_block\QRUrlServicePluginInterface;

/**
 * @QRUrlServicePlugin(
 *   id = "my_qr",
 *   label = "My QR service"
 * )
 */
class MyQr extends PluginBase implements QRUrlServicePluginInterface {

  protected \$url = 'https://example.com/qr';

  public function getUrl() {
    return Url::fromUri(\$this->url, ['query' => \$this->getUrlQueryParams()]);
  }

  public function getUrlQueryParams() {
    return [
      'data' => \$this->configuration['data'],
      'size' => "{\$this->configuration['image_width']}x{\$this->configuration['image_height']}",
    ];
  }
}
```

The plugin receives `data` (token-replaced text), `image_width`, `image_height` in `configuration`. `QRImage::build()` calls `getUrl()->toString()` and puts it in an `<img>` `#uri`. Your plugin id then appears in the block's "QR code service plugin" select.

Bundled plugins: `gchart` (Google Chart API, default) and `goqr` (goQR.me) — both build `https://api.qrserver.com/v1/create-qr-code?data=...&size=WxH`.
