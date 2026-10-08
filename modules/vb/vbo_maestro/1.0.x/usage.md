<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
VBO Actions for Maestro provides a Views Bulk Operations action that deletes selected Maestro workflow processes, and their associated data, directly from a view of `maestro_process` entities.
---
Maestro is a workflow engine whose in-flight and completed processes are stored as `maestro_process` entities. This module ships a single VBO `@Action` plugin, `vbo_maestro_delete_process` (label "Delete selected processes and associated data.", `type = maestro_process`, `confirm = TRUE`), extending `ViewsBulkOperationsActionBase`. Its `execute()` calls `MaestroEngine::deleteProcess()` for each selected process so the engine tears down the process and its related task/production data cleanly rather than just removing the entity row.

Access is gated per row: the action is allowed if the user has the `delete maestro process entities` permission, otherwise it falls back to the entity's own `delete` access check. There are no routes, forms, services or config provided by this module — it only registers the action, which becomes available once you add a Views Bulk Operations field to a view listing Maestro processes.

Setup is entirely in Views: build (or use) a view of Maestro process entities, add the "Views bulk operations" field, and enable the "Delete selected processes and associated data." action. Administrators then select processes in the view and run the bulk delete, confirming on the VBO confirmation step.

---

- Bulk-delete Maestro workflow processes from a view
- Add a 'Delete selected processes and associated data' action to a VBO view
- Clean up completed or abandoned Maestro processes in batches
- Tear down a process and its related task/production data via MaestroEngine::deleteProcess()
- Build a view of maestro_process entities and act on them in bulk
- Require the 'delete maestro process entities' permission for bulk deletion
- Fall back to per-entity delete access when the global permission is absent
- Confirm deletions through VBO's confirmation step (confirm = TRUE)
- Remove stuck in-flight workflow processes during maintenance
- Select multiple processes at once instead of deleting one by one
- Integrate Maestro cleanup into an existing VBO-powered admin listing
- Restrict who can bulk-delete processes via Drupal permissions
- Combine with Views filters to target processes by template or status
- Provide an admin-facing bulk workflow-maintenance tool
- Avoid orphaned Maestro data by using the engine's delete over raw entity delete
- Schedule periodic cleanup by exposing the action on a maintenance view
