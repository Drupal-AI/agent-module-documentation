# Quick Tabs plugin types

Quick Tabs defines two plugin types, each with an attribute + legacy annotation
and a manager service.

## TabType — a content source for a tab

- Manager service: `plugin.manager.tab_type` (`Drupal\quicktabs\TabTypeManager`).
- Subdir: `Plugin/TabType`. Interface: `Drupal\quicktabs\TabTypeInterface`.
  Base class: `Drupal\quicktabs\TabTypeBase`.
- Attribute: `Drupal\quicktabs\Attribute\TabType` (args `id`, `name`,
  optional `deriver`). Legacy annotation `@TabType` also supported.
- Alter hook: `hook_quicktabs_tab_type_info`. Cache id `quicktabs_tab_types`.
- Built-in ids: `node_content`, `block_content`, `view_content`, `qtabs_content`.

Interface methods to implement:
- `optionsForm(array $tab)` — return the form elements shown on the tab's
  add/edit row (the settings stored under `configuration_data[i]['content']`).
- `render(array $tab)` — return a render array for the tab's content.

Example skeleton:

```php
namespace Drupal\my_module\Plugin\TabType;

use Drupal\Core\StringTranslation\TranslatableMarkup;
use Drupal\quicktabs\Attribute\TabType;
use Drupal\quicktabs\TabTypeBase;

#[TabType(
  id: 'my_source',
  name: new TranslatableMarkup('my source'),
)]
class MySource extends TabTypeBase {
  public function optionsForm(array $tab) { /* return form elements */ }
  public function render(array $tab) { /* return a render array */ }
}
```

Tip: for AJAX-loadable sources, see `QuickTabsAjaxSourceRequestTrait` and
`EmptyTabTypeInterface` (lets `hide_empty_tabs` detect empty output).

## TabRenderer — presentation style for the whole instance

- Manager service: `plugin.manager.tab_renderer` (`Drupal\quicktabs\TabRendererManager`).
- Subdir: `Plugin/TabRenderer`. Interface: `Drupal\quicktabs\TabRendererInterface`.
  Base class: `Drupal\quicktabs\TabRendererBase`.
- Attribute: `Drupal\quicktabs\Attribute\TabRenderer` (args `id`, `name`,
  optional `deriver`). Legacy annotation `@TabRenderer` also supported.
- Alter hook: `hook_quicktabs_tab_renderer_info`. Cache id `quicktabs_tab_renderers`.
- Built-in ids: `quick_tabs` (base module); `accordion_tabs` (quicktabs_accordion);
  `ui_tabs` (quicktabs_jqueryui).

Interface methods:
- `optionsForm(QuickTabsInstance $instance)` — renderer options form (stored under
  the instance's `options` keyed by renderer id).
- `render(QuickTabsInstance $instance)` — return the full tabset render array.

Example skeleton:

```php
namespace Drupal\my_module\Plugin\TabRenderer;

use Drupal\Core\StringTranslation\TranslatableMarkup;
use Drupal\quicktabs\Attribute\TabRenderer;
use Drupal\quicktabs\Entity\QuickTabsInstance;
use Drupal\quicktabs\TabRendererBase;

#[TabRenderer(
  id: 'my_renderer',
  name: new TranslatableMarkup('my renderer'),
)]
class MyRenderer extends TabRendererBase {
  public function optionsForm(QuickTabsInstance $instance) { /* form */ }
  public function render(QuickTabsInstance $instance) { /* render array */ }
}
```

Renderers typically inject `plugin.manager.tab_type` to render each tab's content
(see AccordionTabs / UiTabs / QuickTabs for full examples).
