<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# GraphQL Fragment Include (graphql_fragment_include) — agent index

**Overrides the GraphQL `QueryProcessor` to inline `# include path.gql` fragment files from a configured base directory into a query before execution (recursive, load-once).**

- **Version:** 8.x-1.x
- **Core:** >=9
- **Dependencies:** `graphql` (^8.x-3.2), `graphql_core`.
- **Service:** `graphql_fragment_include.graphql_fragment_loader`; `QueryProcessor` decorates the base processor's `executeSingle()`.
- **Configure:** `/admin/config/graphql/fragment-include` (`administer site configuration`) → `fragments_base_dir` (leading slash, relative to DRUPAL_ROOT).

**Security:** include paths are resolved with `realpath()` and constrained to the configured base dir; inlining is a text transform that does not bypass GraphQL resolver access control. Minor: the containment check `GraphQLFragmentLoader.php:134-135` compares the path prefix without a trailing separator, so a sibling directory whose name shares the base-dir prefix could be read by a query-capable client (low severity, requires that directory layout); it also reads any file type under the base dir, not just `.gql`. See report.

See [configure/graphql_fragment_include.md](configure/graphql_fragment_include.md).