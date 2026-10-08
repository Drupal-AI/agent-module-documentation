# Configure Layout Builder Admin Theme

The module has exactly **one setting** that turns the admin-theme override on or off.

## The setting

- Config object: `layout_builder_admin_theme.config`
- Key: `lbat_enable_admin_theme` (boolean)
- **Default: `true`** (shipped in `config/install/layout_builder_admin_theme.config.yml`)
- `true` ⇒ Layout Builder editing screens use the admin theme; `false` ⇒ they keep the
  front-end theme (the negotiator's `applies()` returns early).

There is **no config schema** shipped, so `drush config:set` will warn about a missing schema —
the value still saves correctly.

## Config form (UI)

- Route: `layout_builder_admin_theme.lbat_config_form`
- Path: `/admin/config/content/lbat` (menu link under *Configuration → Content authoring*)
- Permission: `administer site configuration`
- The form (`LBATConfigForm`, a `ConfigFormBase`) is a single checkbox **"Enable admin theme
  for layout builder"** bound to `lbat_enable_admin_theme`. Tick/untick and **Save
  configuration**.

## Toggle via Drush

```bash
# turn OFF
drush config:set layout_builder_admin_theme.config lbat_enable_admin_theme false -y
# turn ON
drush config:set layout_builder_admin_theme.config lbat_enable_admin_theme true -y
# read it back
drush config:get layout_builder_admin_theme.config lbat_enable_admin_theme
```

## Toggle via php:eval (boolean-safe)

```php
\Drupal::configFactory()->getEditable('layout_builder_admin_theme.config')
  ->set('lbat_enable_admin_theme', TRUE)   // or FALSE
  ->save();
```

## Which theme does it switch to?

Not configurable here — the negotiator uses the site's **admin theme**, i.e.
`system.theme:admin` (see [../api/theme-negotiator.md](../api/theme-negotiator.md)). To change
the theme Layout Builder editing uses, change the site's admin theme at
`/admin/appearance` (or `drush config:set system.theme admin <theme>`).
