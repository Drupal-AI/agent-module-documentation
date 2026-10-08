<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# matchmedia - agent index

Compatibility shim: re-provides the `matchmedia` / `matchmedia.addListener` JS asset libraries
that core removed in Drupal 9. No config, routes, permissions, or services.

Key facts:
- `matchmedia.module` `hook_library_info_alter()` unsets `core`'s `matchmedia` + `matchmedia.addListener`,
  and rewrites other extensions' `core/matchmedia*` dependencies to `matchmedia/matchmedia*`.
- Feature is entirely "enable the module"; `hook_help()` points to change record node/3086653.
- `core_version_requirement: ^8 || ^9 || ^10`. Version dir `8.x-1.x` (release 8.x-1.1).
