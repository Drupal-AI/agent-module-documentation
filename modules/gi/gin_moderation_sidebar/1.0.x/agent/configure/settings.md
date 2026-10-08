# Configure Gin Moderation Sidebar

## The only setting

| Item | Value |
|---|---|
| Config object | `gin_moderation_sidebar.settings` |
| Key | `tab_style` |
| Allowed values | `default`, `contrast` |
| Shipped default | `default` (see `config/install/gin_moderation_sidebar.settings.yml`) |
| Schema | `gin_moderation_sidebar.schema.yml` → `tab_style: string` |

The settings form (`\Drupal\gin_moderation_sidebar\Form\ModuleConfigForm`) offers a single
`radios` element labelled *"Choose the Moderation Sidebar tab style."* with options
**Default** and **High contrast**.

- Route: `gin_moderation_sidebar.settings_form`
- Path: `/admin/config/user-interface/gin-moderation-sidebar`
- Permission: `administer site configuration`
- Menu link: under *Administration » Configuration » User Interface*.

## Set it via Drush

```bash
drush config:set gin_moderation_sidebar.settings tab_style contrast -y   # High contrast
drush config:set gin_moderation_sidebar.settings tab_style default  -y   # Default
drush config:get gin_moderation_sidebar.settings tab_style               # read current value
```

## What the value does at runtime

Both effects only fire when Gin is the active admin theme
(`_gin_toolbar_gin_is_active()` from `gin_toolbar`); otherwise the hooks return early.

- `gin_moderation_sidebar_preprocess_html()` adds a body class:
  `gms--tab-style-<style>` (the value is run through `Html::getClass()`), e.g.
  `body.gms--tab-style-contrast`.
- `gin_moderation_sidebar_preprocess_page()` attaches the library
  `gin_moderation_sidebar/main`, which loads `css/gin_moderation_sidebar.css`.

There is **no** per-user, per-role, or per-content setting — `tab_style` is a single global
string. Gin's own high-contrast mode also produces the contrast appearance automatically.

## Export for deployment

```yaml
# config export: gin_moderation_sidebar.settings.yml
tab_style: contrast
```
