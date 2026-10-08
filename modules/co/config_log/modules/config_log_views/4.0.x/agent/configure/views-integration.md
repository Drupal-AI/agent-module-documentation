# The Config Log view & diff field

## The view

Installing `config_log_views` imports one view, **`views.view.config_log`**:
- `base_table: config_log`
- Page display at **`admin/reports/config-log`**, menu title "Config Log" under
  *Administration -> Reports*.
- Requires the parent `config_log` module's `custom` (DB) destination to be logging, otherwise
  the table is empty.

It is an ordinary view -- clone it, add exposed filters, add a data-export display, or embed it
in a block. `configure` for both modules resolves to `config_log.admin`
(`/admin/config/development/config_log`).

## Views data (`hook_views_data`)

The `config_log` table is exposed with handlers on every column:

| Field | Handlers |
|---|---|
| `clid` | numeric field/sort/filter/argument |
| `uid` | numeric + **relationship** to `users_field_data` (base field `uid`) |
| `created` | date field/sort/filter/argument |
| `data` | standard field / string filter |
| `originaldata` | standard field / string filter |
| `name` | standard field / string filter ("Configuration Name") |
| `old_name` | standard field / string filter (rename source) |
| `diff_field` | **virtual** field only, handler id `config_log_diff` ("Difference") |

## The diff field -- `config_log_diff`

Plugin class `Drupal\config_log_views\Plugin\views\field\ConfigLogDiff` (attribute
`#[ViewsField("config_log_diff")]`). In `render()` it:
- explodes the row's `originaldata` and `data` YAML into lines and builds a
  `Drupal\Component\Diff\Diff`,
- formats it with the core `diff.formatter` service, setting
  `leading_context_lines` / `trailing_context_lines` from `config_log.settings`,
- returns a `table` with class `diff` and header From/To; if the diff is longer than 7 rows it is
  wrapped in a collapsed `details` element ("Text too long to display, expand for a full view"),
- returns `t('No change')` when the two sides are identical.

`config_log_views_views_pre_render()` attaches `system/diff` to the `config_log` view so the
table gets core diff styling. To change how much surrounding context each diff shows, edit
`config_log.settings:leading_context_lines` / `trailing_context_lines` (0-50) -- see the parent
module's `configure/settings.md`.

## Restore the shipped view

If the view is ever deleted, re-import it from the module's default config:

```php
use Symfony\Component\Yaml\Yaml;
$p = \Drupal::service('extension.list.module')->getPath('config_log_views')
   . '/config/install/views.view.config_log.yml';
$data = Yaml::parseFile(DRUPAL_ROOT . '/' . $p);
\Drupal::configFactory()->getEditable('views.view.config_log')->setData($data)->save(TRUE);
```

(or `drush config:import --partial --source=...` from the module's `config/install`).
