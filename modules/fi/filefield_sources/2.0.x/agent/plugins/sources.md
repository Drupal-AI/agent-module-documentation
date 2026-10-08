# The FilefieldSource plugin type

## The plugin type

- Annotation: `Drupal\filefield_sources\Annotation\FilefieldSource` (`@FilefieldSource`) with
  properties `id`, `name` (select-list text), `label`, `description`, `weight`.
- Manager service: `plugin.manager.filefield_sources` (class `FilefieldSourceManager`, parent
  `default_plugin_manager`), aliased `filefield_sources`. Plugins live in
  `src/Plugin/FilefieldSource/`.
- Interface: `Drupal\filefield_sources\FilefieldSourceInterface`, requiring two **static** methods:
  - `value(array &$element, &$input, FormStateInterface $form_state)` — value callback: convert the
    source's input into a file value for the element.
  - `process(array &$element, FormStateInterface $form_state, array &$complete_form)` — process
    callback: build the source's UI sub-element on the widget.

Plugins may also declare two optional statics:
- `settings(WidgetInterface $plugin)` — returns a settings sub-form merged into the "File sources"
  details on the widget config (its values are stored under `source_<id>` — see
  [../configure/sources.md](../configure/sources.md)).
- `routes()` — returns `Symfony\Component\Routing\Route[]`; all plugins' routes are merged by
  `FilefieldSourcesRoutes::routes()` (referenced from `filefield_sources.routing.yml` via
  `route_callbacks`). Used for autocomplete/browse endpoints.

## Built-in sources

| id | label | what it does | notable extras |
|---|---|---|---|
| `upload` | Upload | core default (always present) | injected by `filefield_sources_info()`, weight -10 |
| `imce` | File browser | pick via the IMCE browser | only if IMCE installed & `Imce::access()`; weight -1 |
| `remote` | Remote URL | download a file from a URL | has `routes()`, `settings()`; weight 0 |
| `reference` | Reference existing | autocomplete an existing managed file | `source_reference` settings (autocomplete, search_all_fields); weight 1 |
| `clipboard` | Clipboard | paste a file from the clipboard | weight 1 |
| `attach` | File attach | pick a file from a server directory | `source_attach` settings (path, absolute, attach_mode); weight 3 |

`filefield_sources_info()` assembles this list (adding `upload`, dropping `imce` when unavailable)
and `filefield_sources_list()` reduces it to id → name for the checkboxes.

## Writing a source plugin

```php
namespace Drupal\my_module\Plugin\FilefieldSource;

use Drupal\Core\Form\FormStateInterface;
use Drupal\filefield_sources\FilefieldSourceInterface;

/**
 * @FilefieldSource(
 *   id = "my_source",
 *   name = @Translation("My source"),
 *   label = @Translation("My source"),
 *   description = @Translation("Populate the field from my provider."),
 *   weight = 2
 * )
 */
class MySource implements FilefieldSourceInterface {
  public static function value(array &$element, &$input, FormStateInterface $form_state) { /* ... */ }
  public static function process(array &$element, FormStateInterface $form_state, array &$complete_form) { /* ... */ return $element; }
  // Optional: public static function settings(WidgetInterface $plugin) { ... }
  // Optional: public static function routes() { return [ ... ]; }
}
```

The new source id then appears in the "File sources" checkboxes on any supported widget. To make it
available on a **custom** widget too, implement `hook_filefield_sources_widgets()` (see
[../hooks/hooks.md](../hooks/hooks.md)).
