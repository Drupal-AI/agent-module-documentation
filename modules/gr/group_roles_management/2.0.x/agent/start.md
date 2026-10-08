<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Group roles management — agent index

Extends **Group**: grant permission to **manage members of a specific group role** (per-role delegation
of member administration). Requires **PHP 8.3**; depends on `group`; provides permissions. Version
**2.0.0**. Core `^10||^11`.

**Access-adjacent:** managing a role controls who holds it — configure per-role permissions to match
your trust model so delegation can't escalate (don't let a lower role manage a higher one).
