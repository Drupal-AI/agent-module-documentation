# Add token support to another Views filter

The module ships token-aware replacements for `string`, `numeric`, `date`, `datetime`,
`combine`, `list_field`, `geofield_proximity_filter`. To make another filter id token-aware,
register a replacement plugin with the **same id** as the original filter.

## Plugin type

| Piece | Value |
|---|---|
| Discovery dir | `src/Plugin/views/filter/token/` |
| Manager | `plugin.manager.token_views_filter` (extends `default_plugin_manager`) |
| Interface | `Drupal\token_views_filter\TokenViewsFilterPluginInterface` (`replaceTokens(&$value)`) |
| Trait | `Drupal\token_views_filter\TokensFilterTrait` (adds option, form, `preQuery()`) |
| Alter hook consumed | `token_views_filter` (manager alterInfo) |

The magic: `token_views_filter_views_plugins_filter_alter()` iterates all Views filter
definitions and, for any id this manager also defines, overwrites `$definition['class']` with
the manager's class. So your plugin's id **must equal** the core/contrib filter id you want to
tokenise, and your class **must extend** that original filter.

## Recipe

```php
namespace Drupal\my_module\Plugin\views\filter\token;

use Drupal\token_views_filter\TokensFilterTrait;
use Drupal\token_views_filter\TokenViewsFilterPluginInterface;
use Drupal\some_module\Plugin\views\filter\MyOriginalFilter;

/**
 * @Plugin(
 *   id = "my_original_filter_id",
 * )
 */
class TokensMyFilter extends MyOriginalFilter implements TokenViewsFilterPluginInterface {

  use TokensFilterTrait;

  public function replaceTokens() {
    $this->value = $this->token->replace($this->value, ['view' => $this->view], ['clear' => TRUE]);
  }
}
```

For filters whose value is an array (`min`/`max`/`value`), model your `replaceTokens()` on
`TokensDateFilterTrait` / `TokensGeofieldFilterTrait` (they replace each element).

## Schema

Add the `use_tokens` boolean to your filter's schema mapping so config validates. Note the
core module does this at runtime via `hook_config_schema_info_alter()` (see the README's
schema section); if you ship your own filter schema, add:

```yaml
    use_tokens:
      type: boolean
      label: 'Use tokens'
```

Clear caches (`drush cr`) so the plugin manager and the class-swap alter pick up your plugin.
