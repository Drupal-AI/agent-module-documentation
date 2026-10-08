<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# File View Access — agent index

Adds a **`file view access` permission** for files. Depends on core `file`. Provides permissions. Version
**2.1.0**. Core `^8||^9||^10||^11`.

The access handler applies `allowedIfHasPermission('file view access')` to **public**-scheme file entities.
For download gating, Drupal's standard mechanism is the **private scheme** + `hook_file_download`.
