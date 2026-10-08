<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Modules Weight gives you a UI and Drush commands to change the weight (execution order) of installed modules, so you can control which module's hook implementations run first without editing the database or writing code.

---

Module weight decides the order in which modules' hook implementations fire (lower weight runs earlier); normally you'd change it with a raw SQL update or a one-off `module_set_weight()` call. Modules Weight replaces that with a form at *Configuration › System › Modules Weight* (`/admin/config/system/modules-weight`) listing each installed, compatible module with an editable weight, plus a settings page (`/admin/config/system/modules-weight/configuration`) whose single option `show_system_modules` decides whether Drupal Core modules are shown/reorderable. Both pages require the `administer modules weight` permission. Under the hood weights are stored in the `core.extension` config object's `module` map and applied via core's `module_set_weight()`. The module also ships three Drush commands — `mw-list` (`mw-l`) to print the modules-and-weights table, `mw-reorder` (`mw-r`) to read or set a module's weight (with a `--minus` option for negative values and a `--force` to touch Core modules), and `mw-show-system-modules` (`mw-ssm`) to read or toggle the show-Core-modules option — backed by a `modules_weight` service (`ModulesWeight::getModulesList()`). It has no plugins and no external dependencies.

---

- Make one module's `hook_form_alter()` run after another's by giving it a higher weight.
- Ensure a module's `hook_entity_presave()` fires before a second module's implementation.
- Reorder modules through a UI instead of running SQL against `core.extension`.
- Set a module's weight from the command line with `drush mw-reorder mymodule 5`.
- Read a single module's current weight with `drush mw-reorder mymodule`.
- List every module and its weight with `drush mw-list`.
- Include Core modules in the reorder list by enabling "show system modules".
- Toggle the show-Core-modules option from Drush with `drush mw-show-system-modules on`.
- Assign a negative weight (run very early) using `drush mw-reorder mymodule 3 --minus`.
- Force-reorder a Core module from Drush with `drush mw-reorder --force`.
- Fix a module whose alter hook is being overridden by loading it later than intended.
- Guarantee a logging/audit module runs last by giving it the heaviest weight.
- Make a field-default or token-providing module run before consumers that depend on it.
- Audit the current execution order of all contrib modules at a glance.
- Deploy a consistent module execution order across environments via exported `core.extension`.
- Resolve a hook race between two contrib modules without patching either.
- Reorder a theme-suggestion-altering module to win over another.
- Put a permissions/access module earlier so its access checks take precedence.
- Adjust execution order for a module that must initialize state before others.
- Give site builders a safe admin screen to tune module order instead of hacking config.
- Reset a module's weight back to 0 (default) through the UI or Drush.
- Only expose contrib modules (hide Core) in the reorder UI by leaving `show_system_modules` off.
- Script bulk weight changes across a release using the Drush commands.
- Diagnose "why does the wrong module win this hook?" by inspecting weights via `mw-list`.
