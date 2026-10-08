# ViewsReferenceSetting plugin type

The module DEFINES this plugin type (manager `plugin.manager.viewsreference.setting`,
`src/Plugin/ViewsReferenceSettingManager.php`). Each plugin adds one per-embed control that
editors see on the widget and that alters the `ViewExecutable` at render time.

- Discovery dir: `Plugin/ViewsReferenceSetting/`
- Annotation: `@ViewsReferenceSetting` (id, label, default_value)
- Interface: `ViewsReferenceSettingInterface` — `alterFormField(array &$form_field)` and
  `alterView(ViewExecutable $view, $value)`.

## Built-in plugins
| id | Purpose |
|---|---|
| `argument` | contextual filter values (`/`-separated, token-aware) |
| `title` | override the view title |
| `header` | inject custom header markup |
| `pager` | override pager behavior |
| `limit` | override items-per-page |
| `offset` | override result offset |

## Implement one
```php
namespace Drupal\my_module\Plugin\ViewsReferenceSetting;

use Drupal\Component\Plugin\PluginBase;
use Drupal\views\ViewExecutable;
use Drupal\viewsreference\Plugin\ViewsReferenceSettingInterface;

/**
 * @ViewsReferenceSetting(
 *   id = "my_setting",
 *   label = @Translation("My setting"),
 *   default_value = "",
 * )
 */
class MySetting extends PluginBase implements ViewsReferenceSettingInterface {
  public function alterFormField(array &$form_field) {
    $form_field['#description'] = $this->t('Help text on the widget.');
    $form_field['#weight'] = 50;
  }
  public function alterView(ViewExecutable $view, $value) {
    // Mutate $view based on the editor-entered $value.
  }
}
```
Enable it on a field via the field's **Enabled settings** setting. See the `argument` plugin for
a token + current-route example.
