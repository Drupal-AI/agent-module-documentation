# jquery_ui_tabs — agent start

Re-provides the deprecated jQuery UI **Tabs** widget (removed from Drupal core) as an asset
library so themes/modules can keep rendering tabbed interfaces. No config UI, no permissions,
no services, no PHP of its own — it just carries the assets and depends on the base `jquery_ui`
module. jQuery UI is End-of-Life upstream — prefer migrating off it for new code.

## Attach the library

- [Attach `jquery_ui_tabs/tabs` and why this module exists](theming/jquery_ui_tabs.md) — the one
  library id, attaching it via `#attached`, its `jquery_ui` dependency, and the post-core-removal rationale.

```php
$build['#attached']['library'][] = 'jquery_ui_tabs/tabs';
```
