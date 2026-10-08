<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Contextual Filters OR — agent index

Adds one per-display checkbox, **Contextual filters OR**, that turns a View's
contextual filters (arguments) into an OR match instead of the default AND. No admin
page, no permission, no Drush — the whole feature is a boolean stored on the display's
query plugin: `display.<id>.display_options.query.options.contextual_filters_or`.

- Enable/store the OR option on a view (config path, UI location, drush): [configure/contextual-filters-or.md](configure/contextual-filters-or.md)
- How it works internally (swapped query & display plugins, SQL vs Search API): [api/query-plugins.md](api/query-plugins.md)
