<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
GraphQL Compose: Fragments walks the schema GraphQL Compose builds and auto-generates a GraphQL fragment for every object and union type, showing them in an admin form to copy into your front-end and, optionally, exposing them through the schema's own `info { fragments }` query.

---

GraphQL Compose turns a site's entity types, bundles and fields into a large GraphQL schema, and the tedious part of consuming it is writing a field selection for each type. This add-on removes that first-draft chore: its `FragmentManager` service loads every registered object and union type, expands their fields (recursing into nested object/union fields as `...FragmentChildType` references and flagging self-recursion for you to resolve by hand), and emits a named fragment such as `fragment FragmentNodePage on NodePage { … }`. The results appear at `/admin/config/graphql_compose/fragments` (permission `administer graphql configuration`), split into Union Types and Object Types, each fragment in its own collapsible code block ready to copy. Nothing is written to disk and there is no Drush command — the module is a generator you read from, not a file pipeline. The maintainers are explicit that "these fragments are intended as a guide, not a solution": they give a complete-by-default starting point you then trim. Optionally, ticking "Enable fragments on schema" (stored as `graphql_compose.settings:settings.fragments_enabled`, off by default) registers a `fragments` field on the `SchemaInformation` type so a client can pull the same fragment strings — with `type`, `name`, `class`, `content`, `entity`, `bundle` and `dependencies` — straight from the running endpoint via `info { fragments }`, filterable by `entity`/`bundle` and able to pull dependency fragments transitively with `withDependencies`. It is a thin extension: PHP 8.1, GraphQL Compose 2 or 3, no permissions or routes of its own beyond the admin form, inheriting GraphQL Compose's access model.

---

- Generate a GraphQL fragment for every object type in a Compose schema.
- Generate a fragment for every union type, spreading its member type fragments.
- Get a complete starting selection instead of hand-writing fields per type.
- Copy a per-type fragment out of the admin form into a front-end query.
- See the fragment for a specific content type (e.g. `FragmentNodePage`) to copy.
- Onboard a front-end developer to an unfamiliar composed schema.
- Discover what fields a type actually exposes without reading introspection by hand.
- Expose fragments through the live endpoint via `info { fragments }` for tooling.
- Fetch fragments for one entity type by passing the `entity` argument.
- Fetch fragments for one bundle by passing the `bundle` argument.
- Pull a fragment plus all fragments it depends on with `withDependencies: true`.
- Read each fragment's `dependencies` list to resolve nested fragment references.
- Feed the exposed fragment strings into a custom codegen or scaffolding step.
- Use generated fragments as a first draft, then trim to what the client needs.
- Handle recursive types manually where the generator flags `# Recursion`.
- Keep a quick reference of the schema shape reachable from the admin UI.
- Bootstrap queries for a decoupled front end early in a build.
- Reduce duplication by reusing generated per-type fragments across queries.
- Regenerate the admin view after the content model changes to spot new fields.
- Toggle schema exposure off in production once fragments are captured.
