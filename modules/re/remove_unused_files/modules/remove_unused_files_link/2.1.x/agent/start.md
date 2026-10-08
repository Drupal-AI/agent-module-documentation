<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# remove_unused_files_link — agent index

Submodule of **remove_unused_files**. Provides a link/action to trigger removal of unused files. Core `>=10`. Depends on `remove_unused_files`.

**Same data-loss caveat as the parent:** file_usage=0 is an unreliable 'unused' signal — verify before deleting. See [[remove_unused_files]].