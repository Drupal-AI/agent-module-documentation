<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
GraphQL Fragment Include lets you factor repeated GraphQL fragments into files and pull them into a query with a custom `# include path.gql` comment, keeping large decoupled queries DRY.
---
Because the GraphQL spec has no include mechanism, the module overrides the GraphQL module's `QueryProcessor` service: before a query executes it scans the query text for `# include <file>` lines, resolves each against a configured **fragments base directory**, and inlines the file's contents (recursively, with protection against loading the same fragment twice). Path resolution uses `realpath()` and a containment check that the resolved path starts with the configured base directory, so includes are constrained to that directory tree; unresolved or out-of-bounds includes are skipped and logged. Fragment inlining is a pure **text transformation** of the query — it does not change GraphQL authorization: the assembled query still runs through the normal schema resolvers, which enforce their own access, so a fragment cannot resolve fields a resolver would otherwise deny.

Setup: enable the module (with `graphql`/`graphql_core`), set the fragments base directory at *Configuration > GraphQL > Fragment Include* (`administer site configuration`), drop `.gql` fragment files there, and add `# include name.gql` lines to your queries. Typical use is with the Static Suite export workflow.
---
- Extract a repeated GraphQL fragment to a reusable file
- Include a fragment in a query with `# include Image.gql`
- Nest fragment includes recursively
- Avoid duplicate-fragment errors via load-once protection
- Configure the fragments base directory
- Organise fragments into subdirectories
- Keep decoupled/Static Suite queries DRY
- Share one paragraph fragment across content types
- Centralise media/image field selections in one file
- Log missing or invalid fragment paths to dblog
- Constrain includes to a trusted directory tree
- Reuse fragments across multiple stored queries
- Override the include syntax by extending the loader service
- Reduce query duplication in a headless frontend
- Maintain field selections in one place for consistency