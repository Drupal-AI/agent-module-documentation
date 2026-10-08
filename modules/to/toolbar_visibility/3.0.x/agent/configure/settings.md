# Configure Toolbar Visibility

Config UI: **`/admin/config/toolbar-visibility`** (route `toolbar_visibility.settings`, menu under
*Configuration → User interface*, permission `administer toolbar visibility`).

## Config object `toolbar_visibility.settings`

No schema file ships (`provides_config_schema` = false). Keys written by the form:

| Key | Type | Meaning |
|---|---|---|
| `themes` | map `theme_name => bool` | Checkboxes of every installed theme; a truthy value means "remove the toolbar on this theme". |
| `domains` | array of domain ids | Only set when the contrib `domain` module is enabled; a multi-select of domains on which to remove the toolbar. |

## Behavior — `toolbar_visibility_page_top()`

```php
// Active theme flagged -> drop the toolbar render array.
if ($themes[$active_theme] ?? FALSE) unset($page_top['toolbar']);
// With the domain module: active domain in the list -> drop it too.
if (domain enabled && in_array($domainNegotiator->getActiveId(), $domains)) unset($page_top['toolbar']);
```

The toolbar is simply not rendered on matching themes/domains; it is not an access control — a user
who lacks toolbar access never saw it anyway.

## Set with Drush

```bash
# Hide the toolbar on the "olivero" theme.
ddev drush config:set toolbar_visibility.settings themes.olivero olivero -y
```
(The form stores the theme machine name as both key and value for checked themes.)
