# jquery_ui_droppable — agent start

Re-provides the deprecated jQuery UI **Droppable** interaction (removed from Drupal core) so
themes/modules can keep turning elements into drop targets. No config UI, no permissions, no
services, no plugins. Install it and attach the library. jQuery UI is End-of-Life upstream —
prefer migrating off it for new code.

Depends on `jquery_ui` (>=8.x-1.7) and `jquery_ui_draggable` (>=2.1) — a drop target needs
draggable items to accept.

## Attach the library

- [Attach `jquery_ui_droppable/droppable` and migrate from core](api/jquery_ui_droppable.md)
