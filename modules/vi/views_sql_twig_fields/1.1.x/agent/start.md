<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views SQL Twig Fields — agent index

Adds Views **field/filter/sort/argument plugins that build SQL from admin-authored Twig**. `..._relationship`/
`..._webform` submodules; provides permissions. Version **1.1.1**. Core `^8.8||^9||^10||^11`.

**Security:** a **powerful, admin-only** capability — a Views configurer injects SQL (from Twig) into the
query (equivalent to raw-SQL power). Grant the permission **only to fully-trusted admins**; never expose the
config to untrusted users; write Twig-with-arguments safely (parameterize, don't concatenate untrusted input).
Results still respect the View's access.
