<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `hook_available_conditions_alter()`

The only hook the module invites (`theme_switcher.api.php`). It runs in
`ThemeSwitcherRuleForm::form()` right after
`plugin.manager.condition->getFilteredDefinitions('theme_switcher_ui', $contexts, ['theme_switcher_rule' => $entity])`
and lets you remove (or add/modify) condition plugin definitions before they are rendered as
vertical tabs on the rule form.

```php
/**
 * Implements hook_available_conditions_alter().
 */
function MYMODULE_available_conditions_alter(array &$definitions) {
  // Hide a condition that makes no sense for theme switching.
  unset($definitions['response_status']);
}
```

- `$definitions` is keyed by condition plugin id; values are the plugin definitions.
- It only affects the **form**. A condition already stored in a rule's `visibility` still
  evaluates at runtime even if you hide it here.
- The alter tag is `available_conditions` (invoked as
  `$this->moduleHandler->alter('available_conditions', $definitions)`), so the implementation
  name is `hook_available_conditions_alter`, not `hook_theme_switcher_…`.

## What the module itself removes

`theme_switcher_available_conditions_alter()` in `theme_switcher.module`:

- `current_theme` — always removed (using the current theme to pick the theme would loop).
- `language` — removed unless `language_manager->isMultilingual()` is TRUE.
