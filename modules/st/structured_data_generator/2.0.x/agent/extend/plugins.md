<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extend: structured data plugins

## Write a generator
Create `src/Plugin/StructuredDataGenerator/YourPlugin.php` in your module:

```php
namespace Drupal\your_module\Plugin\StructuredDataGenerator;

use Drupal\Core\Plugin\PluginBase;
use Drupal\structured_data_generator\StructuredDataGeneratorInterface;
use Spatie\SchemaOrg\BaseType;
use Spatie\SchemaOrg\Schema;

/**
 * @StructuredDataGenerator(
 *   id = "your_plugin_id",
 * )
 */
class YourPlugin extends PluginBase implements StructuredDataGeneratorInterface {
  public function getStucturedData(): ?BaseType {
    return Schema::organization()->name('Your Org');
  }
  public function getId(): string { return 'your_plugin_id'; }
}
```

Return `null` to emit nothing on a given request (the breadcrumb plugin does this when there are no links).

## How it renders
`structured_data_generator.attachments` collects all plugins on `hook_page_attachments()`, skips those disabled under config `sdg_plugin_settings.disabled_plugins`, and appends each as an `html_head` `<script type="application/ld+json">` with `json_encode($type->toArray(), JSON_UNESCAPED_UNICODE)`.

## Enable/disable
Toggle plugins at `/admin/config/development/structured_data_generator` (perm `administer structured_data_generator`).
