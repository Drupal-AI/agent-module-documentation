<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Link File Browser — agent index

**Adds a file-explorer button to the link field widget** for picking files from a configured (`public://`) folder.
Provides permissions. Version **1.0.7**. Core `^10||^11||^12`.

The file-listing endpoint is `ajax/list-files` (permission `view link file browser`); it returns file/dir names and
paths as JSON (recursive). Grant `view link file browser` only to trusted editor roles.
