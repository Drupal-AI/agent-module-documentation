<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# File Access Fix — agent index

Moves files between **public/private storage by their parent entities' anonymous access** — keeps files of
non-public entities **private** (closes the *"unpublished node's public image is still downloadable"* leak).
Checks file usages + `hook_file_download`. Depends on core `file`. Version **8.x-1.2**. Core `^9.3||^10||^11`.

**Positive security control.** Ensure the **private filesystem is configured** + served access-checked;
verify the access mapping matches intent; test against your workflow. (Cf. `file_visibility`.)
