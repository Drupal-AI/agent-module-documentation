<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# VBO File Status — agent index

A **Views Bulk Operations action to change file status (permanent/temporary)** on file entities. Depends on
`views_bulk_operations`. Version **1.0.0**. Core `^10.1||^11`.

Admin/developer — runs behind the view's access + VBO action perms; temporary files get garbage-collected. No
access role of its own.
