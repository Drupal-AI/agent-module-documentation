<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# workbench_access_hooks — agent start

Hidden, **test-only** submodule of **workbench_access** (ships under the parent's
`tests/modules/`). It exists purely as a worked example of one hook and has no config, UI,
services, or permissions. Depends on `workbench_access`.

- The single hook it demonstrates — `hook_workbench_access_scheme_update_alter()` → [hooks/hooks.md](hooks/hooks.md)
