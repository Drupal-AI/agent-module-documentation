<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Route Condition — agent index

One Condition plugin, id **`route`**, that matches the **active route name** (like core's
"Pages" condition matches URL paths). No config UI of its own (`configure: null`), no
services, no Drush, no permissions. Config schema: `condition.plugin.route` with one key
`routes`.

- **Use it for block visibility / read where it stores config, wildcards, negation, evaluate logic** →
  [plugins/route-condition.md](plugins/route-condition.md)

Key facts: plugin id `route`; single config key `routes` (textarea, one route name per line);
`*` = wildcard (regex `.*`), leading `~` = exclude that route; case-insensitive; empty =
matches everywhere; first matching line wins; standard "Negate the condition" also applies.
On a block it is stored at `block.block.<id>` → `visibility.route.routes`.
