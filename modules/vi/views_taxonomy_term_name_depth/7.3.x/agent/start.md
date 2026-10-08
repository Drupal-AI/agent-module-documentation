<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Taxonomy Term Name Depth — agent index

A single Views **contextual filter (argument)** that matches nodes by taxonomy **term
name** (via Pathauto's alias cleaner) with an optional hierarchy **depth**. No admin
settings form, no permissions, no Drush, no hooks. Depends on `pathauto`. Config lives
entirely on the Views argument. Plugin id: **`taxonomy_index_name_depth`**.

- **Add / configure the contextual filter on a view** (field, depth, vocabularies, multiple values) → [configure/argument.md](configure/argument.md)
- **The Views plugins this module defines** (argument + argument_default ids, options) → [plugins/plugins.md](plugins/plugins.md)
- **How the query & name matching work; services used** → [api/query.md](api/query.md)
