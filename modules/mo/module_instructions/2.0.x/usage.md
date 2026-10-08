<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Module Instructions surfaces each module's README, CHANGELOG and LICENSE files as links on the Extend/module list page, rendered inside the admin UI.
---
The problem it solves: to read a contrib module's docs an admin normally has to open files on disk or the project page. Module Instructions adds inline links on the modules list so those instruction files can be viewed directly in Drupal.

How it works: `hook_form_system_modules_alter()` adds a link per configured instruction type (readme/license/changelog) to each module row, but only for users with the `access module instruction files` permission. Clicking a link hits `/admin/modules/module_instructions/{module}/{file}` (`ModuleInstructionsController::instruction`), which resolves the file relative to the module's own directory via the extension path resolver, reads it, runs it through `_filter_url()` + `check_markup(... 'full_html')`, and prints it in a `<pre>` block. A `hook_module_instructions_pre_view` alter hook lets other modules transform the content first. Which file types are offered is chosen at `/admin/config/system/module-instructions` (permission `manage module instruction settings`); available types come from `hook_module_instructions_info()`. The `{file}` route argument is a single path segment (Drupal routing does not match `/`), so it names a file within the module directory.

Setup: enable the module, visit the settings form to pick which instruction files to expose, and grant `access module instruction files` to roles that should see the links. A Drush command is also provided.
---
- View a module's README from the module list page.
- View a module's CHANGELOG inline in the admin UI.
- View a module's LICENSE inline in the admin UI.
- Choose which instruction file types are shown, via settings.
- Restrict who can view instruction files by permission.
- Restrict who can change the settings by permission.
- Add custom instruction file types via `hook_module_instructions_info()`.
- Transform instruction content with the `module_instructions_pre_view` alter.
- Render Markdown/plain files as full-HTML in a `<pre>` block.
- Auto-link URLs inside instruction files.
- Read module docs without shell/filesystem access.
- Use the provided Drush command for instruction files.
- Keep documentation discovery inside the Drupal admin.
- Show a title combining the module and file name.
- Review a contrib module's license before deploying it.
- Check a module's changelog when planning an upgrade.
- Let non-developers read module docs from the browser.
- Expose only README while hiding LICENSE/CHANGELOG, via settings.
- Onboard site builders by surfacing per-module instructions inline.
