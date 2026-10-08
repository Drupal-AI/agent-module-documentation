<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ai_eca — deprecation and migration to ai_integration_eca

`ai_eca` is a **deprecated** submodule of the `ai` project. `ai_eca.info.yml` declares
`lifecycle: deprecated` with `lifecycle_link` and `@deprecated` docblocks pointing at
[issue 3503947](https://www.drupal.org/project/ai/issues/3503947). It is **removed in AI 2.0.0**.
Its former ECA action/condition plugins now live in the standalone contributed module
**`drupal/ai_integration_eca`** (deprecation began in AI 1.2.0).

## Dependencies (info.yml)

`ai:ai`, `drupal:file`, `eca:eca`, `eca_content:eca_content`. Core `^10.3 || ^11`, package `AI`.

## The migration hook: `ai_eca_update_11001()`

Defined in `ai_eca.install`. It runs in the standard Drupal update context (admin-only —
`drush updatedb` or `/update.php`). Steps:

### 1. Rewrite existing ECA config

`$module_migrations = ['ai_eca' => 'ai_integration_eca', 'ai_eca_agents' => 'ai_integration_eca_agents']`.

For every `eca` config entity (`entityTypeManager()->getStorage('eca')->loadMultiple()`), it edits
the editable config `eca.eca.<id>`:

- In `dependencies.module`, replaces any `ai_eca` / `ai_eca_agents` entry with its new name.
- Only if a dependency changed, it then walks the `actions` array and for each action whose
  `plugin` id starts with `ai_eca_`, computes `str_replace('ai_eca_', 'ai_integration_eca_', ...)`.
  - If `plugin.manager.eca.action` **has** the new definition, the action's `plugin` id is updated.
  - If it does **not**, it logs a `warning` to the `ai_eca` channel and `unset()`s that action
    (the action is dropped from the model).
- Saves the config.

### 2. Ensure the replacement module

Using `module_handler`, `extension.list.module` and `module_installer`:

- If `ai_eca` is already uninstalled -> returns "already been uninstalled".
- If `ai_integration_eca` exists on disk but is not enabled -> `install(['ai_integration_eca'])`
  (no try/catch — a failure surfaces as an error).
- If `ai_integration_eca` is **not** on disk -> `throw new \Exception(...)` instructing the operator
  to `composer require drupal/ai_integration_eca` and re-run the update.
- If `ai_integration_eca` is enabled while `ai_eca` still is -> `uninstall(['ai_eca'])`.

## Recommended migration order

1. `composer require drupal/ai_integration_eca`.
2. `drush updatedb -y` (runs `ai_eca_update_11001`), which rewrites ECA configs, enables the new
   module, and uninstalls `ai_eca`.
3. Review the `ai_eca` log channel for any dropped-action warnings and re-add those actions in the
   ECA editor using the `ai_integration_eca_*` plugins.
4. Build all new AI-in-ECA automation on `ai_integration_eca`, not `ai_eca`.

## Notes

- The shim has no settings page (`configure: null`) and no plugins/routes/permissions/schema of its
  own; nothing to configure directly.
- The hook edits config and installs/uninstalls modules — it is an administrative maintenance
  operation, run only through Drupal's update pipeline, not from any web route.
