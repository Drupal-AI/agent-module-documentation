# BEF widget plugin types & adding a widget

BEF defines **three** plugin types, one per exposed element, each with its own manager
(all instances of `BetterExposedFiltersWidgetManager`, constructed with a `$type`):

| Type | Plugin namespace | Manager service | Attribute | Annotation (legacy) |
|---|---|---|---|---|
| filter | `Plugin/better_exposed_filters/filter` | `plugin.manager.better_exposed_filters_filter_widget` | `Attribute\FiltersWidget` | `@BetterExposedFiltersFilterWidget` |
| pager | `Plugin/better_exposed_filters/pager` | `plugin.manager.better_exposed_filters_pager_widget` | `Attribute\PagerWidget` | `@BetterExposedFiltersPagerWidget` |
| sort | `Plugin/better_exposed_filters/sort` | `plugin.manager.better_exposed_filters_sort_widget` | `Attribute\SortWidget` | `@BetterExposedFiltersSortWidget` |

Common interface `Plugin\BetterExposedFiltersWidgetInterface`; base
`Plugin\BetterExposedFiltersWidgetBase`. Each type also has a per-type base you should
extend: `filter/FilterWidgetBase`, `pager/PagerWidgetBase`, `sort/SortWidgetBase`.
Alter hooks: `hook_better_exposed_filters_better_exposed_filters_<type>_widget_info_alter`.

Built-in filter widgets: `bef` (checkboxes/radios), `bef_links`, `bef_single`,
`bef_hidden`, `bef_number`, `bef_sliders`, `bef_datepicker`, `bef_datetimepicker`,
`default`. Pager/sort: `default`, `bef_links`, `bef` (radios).

## Add a custom filter widget
```php
namespace Drupal\mymodule\Plugin\better_exposed_filters\filter;

use Drupal\better_exposed_filters\Attribute\FiltersWidget;
use Drupal\better_exposed_filters\Plugin\better_exposed_filters\filter\FilterWidgetBase;
use Drupal\Core\Form\FormStateInterface;
use Drupal\Core\StringTranslation\TranslatableMarkup;

#[FiltersWidget(
  id: 'my_widget',
  title: new TranslatableMarkup('My widget'),
)]
class MyWidget extends FilterWidgetBase {

  public function defaultConfiguration(): array {
    return parent::defaultConfiguration() + ['my_option' => FALSE];
  }

  public function buildConfigurationForm(array $form, FormStateInterface $form_state): array {
    $form = parent::buildConfigurationForm($form, $form_state);
    // Add widget option elements here.
    return $form;
  }

  public function exposedFormAlter(array &$form, FormStateInterface $form_state): void {
    parent::exposedFormAlter($form, $form_state);
    // Transform $form[$this->handler->options['expose']['identifier']] into your widget.
  }

  // Optionally override isApplicable() to limit which filter handlers can use it.
}
```
Clear caches (`drush cr`); the widget then appears in the filter's BEF widget selector.
Pager/sort widgets are analogous — use the matching attribute and base class.
