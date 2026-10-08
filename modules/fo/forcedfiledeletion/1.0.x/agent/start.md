<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Forced File Deletion — agent index

**Forces complete deletion of a managed file (physically `unlink()`s it)**, extending the File Delete form.
Provides permissions. Version **1.0.x** (dev). Core `^9||^10||^11`.

File-management admin op — **destructive/irreversible** (deletes disk + record bypassing usage checks;
references break): gate the delete permission to trusted admins, use deliberately. No unauthenticated surface.
