<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# module_instructions — extending & configuring

## Declaring instruction file types
Implement `hook_module_instructions_info()` to add selectable types (keyed machine name → label). The module itself declares `readme`, `license`, `changelog`.

```php
function mymodule_module_instructions_info() {
  return ['upgrade' => ['label' => t('Upgrade guide')]];
}
```

Enabled types are chosen at `/admin/config/system/module-instructions` (config `module_instructions.settings`, key `types`) and stored; `hook_form_system_modules_alter()` then renders a link per enabled type on each module row (only for users with `access module instruction files`).

## Transforming content before display
Implement `hook_module_instructions_pre_view(&$content, $context)` — `$context` has `module`, `file`, `format`. Use it to convert Markdown to HTML or strip content before it is passed to `check_markup()`.

## Viewing
Link target: `/admin/modules/module_instructions/{module}/{file}` → `ModuleInstructionsController::instruction()`; reads `getPath('module', $module) . '/' . $file`, runs `_filter_url()` + `check_markup(..., 'full_html')`, prints in `<pre>`. Requires `access module instruction files`.
