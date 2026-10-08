# Maestro Engine — agent index

Workflow / business-process engine. You author a **template** (task graph), launch **processes**,
and an **orchestrator** advances each process through its **queue**, assigning interactive tasks.
Base module = engine + data model + task plugin system; the visual editor, task console, and
integrations are submodules (not covered here unless enabled). Depends on core `views`.

- **Engine settings, the orchestrator (token/lock/dev mode), how to run it, starting processes** →
  [configure/settings.md](configure/settings.md)
- **The two plugin types (engine tasks + set-process-variable) and the built-in task ids** →
  [plugins/task-types.md](plugins/task-types.md)
- **`MaestroEngine` static API, the entities/tables, status constants** →
  [api/engine.md](api/engine.md)
- **`maestro.hooks.api.php` — the alter/notification/webform/SPV hooks** →
  [hooks/hooks.md](hooks/hooks.md)
- **Drush commands (`maestro:orchestrate`, `maestro:start-process`)** →
  [drush/drush.md](drush/drush.md)
- **Static + dynamic permissions and the entity access handlers** →
  [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Config entity `maestro_template` (the task graph). Content entities/tables: `maestro_process`, `maestro_queue`, `maestro_process_variables`, `maestro_production_assignments`, `maestro_process_status`, `maestro_entity_identifiers`.
- Task plugins: `Plugin/EngineTasks/*` implementing `MaestroEngineTaskInterface` (manager `plugin.manager.maestro_tasks`, `@Plugin` annotation, alter `maestro_tasks_info`). SPV plugins: `Plugin/MaestroSetProcessVariablePlugins/*` (manager `plugin.manager.set_process_variable_plugins`, `@MaestroSetProcessVariablePlugin` annotation).
- Orchestrator route `/orchestrator/{token}` (perm `access content`) is protected by config `maestro_orchestrator_token`, RANDOM per install (`Crypt::randomBytesBase64()`). Settings form: `maestro.maestro_admin_settings` at `/admin/config/workflow/maestro` (perm `administer site configuration`).
- Interactive task execution `/maestro/execute/task/{queueid_or_token}` (perm `access content`) is authorized by task assignment via `MaestroEngine::canUserExecuteTask()`, not by the token alone.
