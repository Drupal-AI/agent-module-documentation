<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Last Login - agent index

Shows the **current user's previous login time** in a block (version **3.0.0**, core `^8||^9||^10`).

- No routes, no config, no DB table; stores last login in a session variable and renders a block.
- Only meaningful to authenticated users viewing their own timestamp.
- Category: Administration tools / Audit trail / activity logging.
