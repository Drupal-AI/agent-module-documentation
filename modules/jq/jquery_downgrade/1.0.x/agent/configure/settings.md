# Configure jQuery Downgrade

## Admin UI

Route `jquery_downgrade.settings` → `/admin/config/development/jquery-downgrade`
(permission: `administer site configuration`). Form fields:

- **Node IDs** — textarea, one node ID per line.
- **View Routes** — checkboxes of every Views page display (labelled `<view> - <display> (route)`).
- **Enable jQuery downgrade for specific themes** — checkbox.
- **Themes that should use jQuery 3** — checkboxes of installed themes (only when the above is on).

Note: in the form, Views route names have their dots turned into `__` for the checkbox keys, then
converted back to dots on save — so the stored value is the real route name (e.g. `view.frontpage.page_1`).

## Config object

`jquery_downgrade.settings` (schema type `config_object`):

```yaml
node_ids:               # sequence of integers (node IDs)
  - 12
  - 34
view_routes:            # sequence of strings (Views page route names)
  - view.frontpage.page_1
enable_theme_downgrade: false   # boolean
downgrade_themes:       # sequence of strings (theme machine names)
  - olivero
```

### Read / write with drush

```bash
drush cget jquery_downgrade.settings
drush cset jquery_downgrade.settings node_ids.0 12 -y
```

```php
\Drupal::configFactory()->getEditable('jquery_downgrade.settings')
  ->set('node_ids', [12, 34])
  ->set('view_routes', ['view.frontpage.page_1'])
  ->set('enable_theme_downgrade', TRUE)
  ->set('downgrade_themes', ['olivero'])
  ->save();
```

## How the downgrade is applied (runtime)

`Drupal\jquery_downgrade\Hook\JQueryDowngradeHooks::alterAttachments()` implements
`hook_page_attachments_alter()` (registered as an autowired service with the `#[Hook(...)]`
attribute). It downgrades when ANY of these is true for the current request:

- the current route's `node` parameter id is in `node_ids`;
- the current route name is in `view_routes`;
- `enable_theme_downgrade` is TRUE and the active theme is in `downgrade_themes`.

When triggered it runs:

```php
unset($attachments['#attached']['library']['core/jquery']);
$attachments['#attached']['library'][] = 'jquery_downgrade/jquery_legacy';
```

## The library

`jquery_downgrade.libraries.yml` defines `jquery_legacy` (version 3.6.4), loading
`https://code.jquery.com/jquery-3.6.4.min.js` (external, weight -20) with a `core/drupal`
dependency. Reference it as `jquery_downgrade/jquery_legacy`.
