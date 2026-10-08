<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Contextual Filters OR adds a single "Contextual filters OR" query-setting checkbox to a View display that switches the WHERE conditions its contextual filters (arguments) generate from the default AND to OR, so a view with several arguments matches rows satisfying *any* of them instead of *all* of them.

---

By default a Views display combines every contextual filter (argument) with AND: a row must match argument 1 AND argument 2 AND …. This module swaps the SQL query plugin (`views_query`) for a subclass, `ExtendedSql`, that overrides `addWhere()`, `addWhereExpression()` and `addHavingExpression()` so that when the display's new `contextual_filters_or` option is on, the default WHERE group (group 0) is created as an `OR` group instead of `AND`. It ships the same behaviour for Search API views by subclassing `SearchApiQuery` as `ExtendedSearchApiQuery`, which rewrites group 0 to `type => OR` in `build()`. The option is exposed as a checkbox under the view display's **Query settings** and is stored in config at `display.<id>.display_options.query.options.contextual_filters_or`; a `hook_config_schema_info_alter()` registers the boolean on both the `views.query.views_query` and `views.query.search_api_query` schemas. Because the flip happens at the query-plugin level it applies to all contextual filters on that display at once (there is no per-argument toggle), and it affects only the default filter group, so exposed/normal filters added to other groups keep their own AND/OR operators. The module also swaps the `entity_reference` display plugin for `ExtendedEntityReference`, which drops the redundant `title` option from that display's options summary. There is no admin settings page, no permission, and no Drush command — the entire feature is the one per-display checkbox.

---

- Show nodes that match *any* of several contextual filters instead of all of them.
- Build a "content by author OR by term" listing where a row appears if either argument matches.
- Combine a node-ID argument and a user-ID argument with OR so passing either returns results.
- Create a related-content view that ORs together several taxonomy-term contextual filters.
- Let a view return items tagged with term A OR term B OR term C via repeated contextual filters.
- Make a Search API view treat its contextual filters as OR conditions.
- Produce a "my content OR content shared with me" view keyed off two arguments.
- Drive an entity-reference selection view whose contextual filters are OR'd for broader matches.
- Match content in category X OR authored by the current user for a personalized feed.
- Widen a faceted contextual-filter view so any single facet argument yields results.
- Support a URL like `/list/1+2+3` where each argument is a different field OR'd together.
- Build a dashboard block that surfaces items matching any of several contextual filters.
- Return products in brand A OR brand B when two brand arguments are supplied.
- Let a menu-driven view match either of two contextual arguments for flexible landing pages.
- Create an "assigned to me OR created by me" task list from two user-reference arguments.
- Aggregate content across multiple content types passed as separate OR'd contextual filters.
- Build a geographic view matching region A OR region B from two contextual filters.
- Provide an RSS feed that includes items matching any of several contextual filters.
- Combine a published-status argument and an author argument with OR logic.
- Toggle a single view between strict (AND) and broad (OR) contextual-filter matching via config.
- Widen search results in a Search API view by OR'ing its contextual arguments.
- Match events in date-range A OR date-range B using two contextual date arguments.
- Return nodes referencing entity X OR entity Y from two entity-reference contextual filters.
- Ship the OR behaviour in exported view config so it deploys across environments.
