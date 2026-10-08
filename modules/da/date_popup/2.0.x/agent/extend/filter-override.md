# How Date Popup overrides Views date filters

`hook_views_plugins_filter_alter()` (`src/Hook/DatePopupViewsHooks.php`) reassigns filter plugin
classes:

- `date` → `Drupal\date_popup\DatePopup` (extends core `views\...\filter\Date`)
- `datetime` → `Drupal\date_popup\DatetimePopup`
- `search_api_date` → `Drupal\date_popup\DatePopupSearchApi` (only if Search API present)

Each subclass uses `DatePopupTrait` and overrides `buildExposedForm()`:
```php
public function buildExposedForm(&$form, FormStateInterface $form_state) {
  parent::buildExposedForm($form, $form_state);
  static::applyDatePopupToForm($form, $this->options);
}
```
`applyDatePopupToForm()` (the trait, with `DatePopupHelper`) converts the exposed date element to
an HTML5 `#type => date`/datetime control. No settings, config schema, or permissions — enable the
module and expose a date filter. To customize, decorate/subclass these filter classes or provide
your own `hook_views_plugins_filter_alter()` at a later weight.
