<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Module Instructions (module_instructions) — agent index

**Adds links on the module list to view a module's README/CHANGELOG/LICENSE rendered in the admin UI.**

- **Version:** 2.0.x
- **Core:** `^9.0 || ^10 || ^11`
- **Routes:** `/admin/modules/module_instructions/{module}/{file}` (`access module instruction files`); settings `/admin/config/system/module-instructions` (`manage module instruction settings`).
- **Hooks:** `hook_module_instructions_info()` (declare file types), `hook_module_instructions_pre_view` alter (transform content); `hook_form_system_modules_alter()` injects the links.
- **Also:** a Drush command (`drush.services.yml`).

**Security:** Both routes permission-gated. `instruction()` resolves the file relative to the requested module's own directory (extension path resolver) and `{file}` is a single route segment (routing does not match `/`), so traversal via unencoded slashes is not possible; content is rendered through `check_markup(..., 'full_html')` behind the `access module instruction files` permission. No anonymous or mutating endpoints.

See [hooks/module_instructions.md](hooks/module_instructions.md).
