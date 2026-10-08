<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `bef_flatpickr` Better Exposed Filters widget

Source: `modules/datetime_flatpickr_bef/src/Plugin/better_exposed_filters/filter/FlatpickrDateBef.php`
(`@BetterExposedFiltersFilterWidget(id = "bef_flatpickr")`).

## Applicability

`isApplicable()` returns TRUE only for a Views **Date** filter — a handler that
`is_a(..., 'Drupal\views\Plugin\views\filter\Date')` or has a `date_handler` — and that is **not**
grouped. So the "Date Picker with Flatpickr" option only appears for exposed date filters.

## Enable it (Views UI)

1. Edit the view, on the exposed filter's display set **Exposed form → Format** to *Better Exposed
   Filters*.
2. In the BEF exposed-form settings, find your date filter and set its widget to *Date Picker with
   Flatpickr*.
3. Open the filter's **Flatpickr settings** group to configure options (shared trait; default
   `dateFormat` `Y-m-d`, plus `enableTime`, `minDate`/`maxDate`, `time_24hr`, etc.).

## Where the selection is stored

In the view config entity, per display:

```
views.view.<view>:
  display.<display_id>.display_options.exposed_form:
    type: bef
    options:
      bef:
        filter:
          <filter_id>:
            plugin_id: bef_flatpickr
            advanced: { … }
            # plus the flatpickr settings saved by submitConfigurationForm()
```

`<filter_id>` is the machine id of the exposed filter (e.g. `created`, `field_date_value`).

## How it renders

- `defaultConfiguration()` merges the trait's default flatpickr settings (and forces `dateFormat` to
  `Y-m-d`).
- `buildConfigurationForm()` adds a `flatpickr_settings` details group (from
  `DateTimeFlatPickrWidgetTrait::getSettingsForm()`); `submitConfigurationForm()` copies those values
  into `$this->configuration`.
- `exposedFormAlter()` sets the exposed element `#type` to `datetime_flatpickr` and copies each config
  value onto the element as a `#`-prefixed property. For a min/max double-date filter it applies to both
  the `min` and `max` inputs. The `datetime_flatpickr` element then attaches the flatpickr library and
  settings (see the parent module's `agent/api/element.md`).

No module-level configuration exists; everything lives inside each view's BEF settings.
