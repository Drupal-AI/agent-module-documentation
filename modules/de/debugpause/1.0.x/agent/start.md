<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Debug Pause (debugpause) — agent index

**Admin-toolbar button that invokes the JS debugger after a configurable delay for breakpoint-free pausing.**

- **Version:** 1.0.x
- **Core:** ^9 || ^10
- **Dependencies:** admin_toolbar:admin_toolbar
- **Config route:** `debugpause.settings` → `/admin/config/development/debugpause` (`_permission: 'use debug pause'`).
- **Hooks:** `hook_toolbar_alter` (attaches `debugpause/toolbar.debug-pause`), `hook_preprocess_menu` (injects `pausein` delay + id, gates visibility on `use debug pause`).
- **Config:** `debugpause.settings` → pausein, displaytitle.

**Security:** single admin form gated by the `use debug pause` permission; toolbar button hidden from users without it. Client-side developer tool with no server-side data handling or anonymous/mutating endpoints. Intended for dev, not production.
