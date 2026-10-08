<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# VBO Actions for Maestro (vbo_maestro) — agent index

**Registers one Views Bulk Operations action to bulk-delete Maestro `maestro_process` entities via `MaestroEngine::deleteProcess()`.**

- **Version:** 1.0.x — core `^9.5 || ^10 || ^11`; depends on `maestro` and `views_bulk_operations`.
- **Action plugin:** `vbo_maestro_delete_process` (`\Drupal\vbo_maestro\Plugin\Action\MaestroDeleteProcess`), `type = maestro_process`, `confirm = TRUE`.
- **Use:** add a VBO field to a view of Maestro processes, enable this action, select rows, run.
- **Access:** allowed with `delete maestro process entities` permission, else falls back to each entity's `delete` access. No routes/services/config of its own.
- **Security:** no anonymous or mutating endpoints; deletion is permission-checked per entity through VBO's confirm flow.
