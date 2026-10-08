# Admin settings (Bootstrap year datepicker)

The only admin UI is a single settings form. There are **no permissions of its own** (guarded
by core `administer site configuration`) and **no Drush commands**.

- **Route:** `views_year_filter.settings`
- **Path:** `/admin/config/views-year-filter/settings` (menu link under
  *Administration › Configuration › User interface*, title "Views year filter settings")
- **Config object:** `views_year_filter.settings` (no schema file ships with the module)
- **Form class:** `Drupal\views_year_filter\Form\SettingsForm`

## The one setting

| Key | Widget | Meaning |
|---|---|---|
| `use_bootstrap_datepicker` | checkbox "Use Bootstrap Datepicker" | Attach a year-only Bootstrap Datepicker popup to **exposed** year (`date_year`) filters |

When enabled, an exposed filter whose value type is `date_year` gets
`autocomplete="off"`, the class `js-datepicker-years-filter`, and the
`views_year_filter/datepicker` library attached (`DateViewsTrait::applyDatePopupToForm()`).
That library pulls the Bootstrap Datepicker JS/CSS from a CDN (Apache-2.0, not GPL-compatible —
it is loaded as an external asset, not bundled).

Saving the form shows the warning *"This config change will take effect after next cache
clear!"* — run `drush cr` after toggling it.

## Set it with drush

```bash
drush config:set views_year_filter.settings use_bootstrap_datepicker 1 -y
drush cr
```

## Related, separate feature (not this setting)

The optional core **`date_popup`** module (if installed) makes the trait upgrade
**non-year** date filter inputs (`value.type !== 'date_year'`) from textfields to HTML5
`date` inputs. This is independent of the Bootstrap datepicker checkbox above.
