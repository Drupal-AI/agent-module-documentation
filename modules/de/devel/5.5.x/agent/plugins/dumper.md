# Plugin type: DevelDumper

Devel defines the `DevelDumper` plugin type — a pluggable backend for rendering variable
dumps. The active backend is chosen by the `devel.settings:devel_dumper` key.

- Manager: `plugin.manager.devel_dumper` → `Drupal\devel\DevelDumperPluginManager`
- Discovery dir: `src/Plugin/Devel/Dumper/`
- Annotation: `Drupal\devel\Annotation\DevelDumper` (`id`, `label`, `description`)
- Interface: `Drupal\devel\DevelDumperInterface`; base class `DevelDumperBase`
- Alter hook: `hook_devel_dumper_info_alter()` (see [../hooks/hooks.md](../hooks/hooks.md))

Built-in: `VarDumper` (`src/Plugin/Devel/Dumper/VarDumper.php`, id `var_dumper`, the
fallback). Kint ships as another dumper when its library is present.

## Implement one
```php
// src/Plugin/Devel/Dumper/MyDumper.php
namespace Drupal\my_module\Plugin\Devel\Dumper;

use Drupal\devel\DevelDumperBase;

/**
 * @DevelDumper(
 *   id = "my_dumper",
 *   label = @Translation("My dumper"),
 *   description = @Translation("Custom variable dumper.")
 * )
 */
class MyDumper extends DevelDumperBase {
  public function export($input, $name = NULL) { /* return string */ }
  public function dump($input, $name = NULL) { /* echo output */ }
  public static function checkRequirements() {
    // Return TRUE only if the backing library is available;
    // otherwise the manager falls back to var_dumper.
    return TRUE;
  }
}
```
Select it at `/admin/config/development/devel` once its `checkRequirements()` passes.
