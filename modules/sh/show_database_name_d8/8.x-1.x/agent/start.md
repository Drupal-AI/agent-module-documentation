<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Show Database Details — agent index

Shows the default DB **host + name** in the admin toolbar (`hook_toolbar`), a block, and the status report (`hook_requirements`). All three check `access database information` (`restrict access: TRUE`). On-disk dir `show_database_name_d8`, machine name `show_database_name`. Depends on `block`. Version **8.x-1.1**, core 8–10.

Info-disclosure surface is permission-gated; not shown to anonymous/low-priv users.