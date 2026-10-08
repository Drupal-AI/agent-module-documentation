# Configure Tab Toolbar

Route `tab_toolbar.settings_form` → `/admin/config/tab_toolbar/settings`
(`SettingsForm`, permission `administer site configuration`).

## Config object `tab_toolbar.settings`

| Key | Type | Default | Effect |
|---|---|---|---|
| `admin.enabled` | bool | `FALSE` | Show the Page Actions tabs tray even while the active theme is the admin theme. When FALSE, the toolbar tabs are hidden on the admin theme. |

The form field id is `admin__enabled` (double underscore); it maps to the nested config key
`admin.enabled` in `submitForm()`.

### Set via Drush

```bash
drush config:set tab_toolbar.settings admin.enabled true -y
```

## Behavior notes

- On every request the module compares the active theme name to `system.theme:admin`. If they are
  equal and `admin.enabled` is FALSE, `hook_toolbar()` returns early (no tabs tray).
- The tray only appears at all when the current route actually has primary local tasks.
- No config schema ships (`config/install/tab_toolbar.settings.yml` seeds `admin.enabled: FALSE`
  only); there is nothing else to configure.

## Theming

Override `tab-toolbar.html.twig` (theme hook `tab_toolbar`, variables `primary` and `secondary`,
each a rendered list of local tasks) in your theme to change how the toolbar tabs list renders.
Individual items still theme through core `menu-local-task.html.twig`.
