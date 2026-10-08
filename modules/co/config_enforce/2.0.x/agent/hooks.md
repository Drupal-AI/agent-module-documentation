<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# config_enforce — hooks

## `hook_config_enforce_form_denylist()`

Return an array of **form IDs** that Config Enforce should never treat as enforceable config forms
(they are skipped in `ConfigResolver::isAnEnforceableForm()` via `moduleHandler()->invokeAll()`).
Declared in `config_enforce.api.php`.

```php
/**
 * Implements hook_config_enforce_form_denylist().
 */
function my_module_config_enforce_form_denylist(): array {
  return [
    'system_site_information_settings',
  ];
}
```

The module's own implementation (`config_enforce.module`) denylists preview/confirm/installer forms:
`view_preview_form`, `block_delete_form`, `install_configure_form`, `install_select_language_form`,
`install_select_profile_form`, `install_settings_form`.

There is no service/plugin to override; enforcement behaviour is otherwise driven by the enforcement
level in each module's registry (see [registry.md](registry.md)).
