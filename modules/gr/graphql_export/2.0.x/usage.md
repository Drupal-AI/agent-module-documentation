<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
GraphQL Export writes out a GraphQL server's schema — as SDL or as a JSON introspection result — from an admin route, a Drush command, or automatically as a post-command hook on `drush config:export`.

---

A decoupled front end usually needs the schema as a file: code generators produce typed clients from it, CI diffs it to catch breaking changes, and reviewers read it to see what an API change actually did. Getting it out of a running Drupal site is the awkward part, and this module makes it a first-class artefact. Three routes under `/admin/config/graphql/servers/manage/{graphql_server}/export` serve the schema, its SDL and its JSON form, each guarded by GraphQL's own `_graphql_explorer_access` check for that server — the same access the explorer uses, so it inherits rather than reinvents the permission model.

The interesting part is the Drush integration. `graphql-export:schema` exports on demand, and a `@hook post-command config:export` means the schema is written whenever configuration is exported. That turns the schema into something that travels with the config in version control: a pull request that changes a type shows the schema change in the diff, and a client generated from the committed file matches the deployed server.

Practical fit: pair it with a codegen step in CI, gate merges on the schema diff being intentional, or simply keep a committed schema so that "what did the API look like at release 3.2" is answerable. Requires PHP 8.1 and, of course, the GraphQL module with at least one server configured.

---

- Export a GraphQL server's schema as SDL.
- Export the JSON introspection result.
- Download a schema from the admin UI.
- Export a schema with a Drush command.
- Write the schema automatically on `drush config:export`.
- Commit the schema alongside configuration.
- Diff schema changes in a pull request.
- Detect a breaking API change in CI.
- Generate a typed front-end client from the exported SDL.
- Give front-end developers a current schema file.
- Document the API surface for reviewers.
- Answer what the schema looked like at a past release.
- Export several servers by id in one command.
- Choose the output type (`graphqls` or `json`) with the `--type` command option.
- View a server's schema read-only in the admin UI before downloading.
- Configure per-server output file paths in `settings.php`.
- Fall back to `private://<server>.graphqls` / `.json` when no path is set.
- Skip a server on config export with `skip_config_export`.
- Keep schema artefacts out of manual copy-and-paste.