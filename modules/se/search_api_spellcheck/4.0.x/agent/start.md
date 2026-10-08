<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Search API Spellcheck — agent index

Two Views **area handlers** that render backend spellcheck data as a "Did you mean:" link or a
list of keyword variations on a Search API search view. **No** configure route, settings form,
service, permission, or Drush command. Its only persistent state is the area handler placed in a
view's `display_options.header` / `.footer`, stored in the `views.view.<id>` config entity.

- **The two plugins, their ids, options, backend requirement, and how to add one to a view** →
  [plugins/spellcheck-areas.md](plugins/spellcheck-areas.md)
- **Theme hooks & templates for customising the output** →
  [theming/templates.md](theming/templates.md)

Key facts:
- Plugin ids: `search_api_spellcheck_did_you_mean` (single best-guess link) and
  `search_api_spellcheck_suggestions` (bulleted variations). Both are core `views_area` handlers
  (`table: views`), not a new plugin type.
- Options (config keys): `search_api_spellcheck_count` (int, max suggestions),
  `search_api_spellcheck_hide_on_result` (bool, hide when the view has results),
  `search_api_spellcheck_collate` (bool, use backend collation).
- Requires a Search API server whose backend `supportsFeature('search_api_spellcheck')` (Solr).
  On a backend without it (e.g. core Database) the handlers render nothing.
