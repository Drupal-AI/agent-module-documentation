<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Parses PHP source code (following Drupal/Doxygen conventions) into a set of content entities and renders browsable, cross-linked, searchable API reference pages — this is the engine behind api.drupal.org.

---
An administrator defines Projects and Branches (a branch points at a directory of code and, for PHP branches, an optional list of function/constant references); the `api.parser` service walks the files with `queue`-backed workers, extracts DocBlocks (files, functions, classes, members, namespaces, references, overrides) into entities, and generates non-volatile URLs under `/api/...`. Function calls are linked to their definitions and to the PHP manual, with hover tooltips. A search subsystem (autocomplete, OpenSearch, per-branch and global search) and a Drush command set (`ApiCommands`) drive reparsing and maintenance.

All display routes require the `access API reference` permission and all administration (settings, wizard, comments import, branch parse) requires `administer API reference` — neither is granted to anonymous users by default, so nothing is exposed unless a site explicitly grants those permissions. The parser reads local files with `file_get_contents` and fetches admin-configured external-branch URLs via the injected HTTP client; branch source locations are set by administrators, not by request input. A public-facing docs site should grant `access API reference` to anonymous roles deliberately.
---
- Stand up a browsable API reference for a codebase.
- Document a Drupal module, theme or the whole core.
- Define a Project and one or more Branches to parse.
- Parse a branch's PHP into DocBlock entities.
- Reparse a branch after code changes via Drush or the branch route.
- Link function calls to their definitions automatically.
- Show PHP-manual links and tooltips for library calls.
- Search the API by function, class or file name.
- Provide OpenSearch/autocomplete for the docs.
- Import legacy comments (with the apidrupalorg add-on).
- Generate stable, predictable documentation URLs.
- Group functions into multiple topic groups.
- Expose namespace and file-reference listings.
- Run the quick wizard to bootstrap a project+branch fast.
- Restrict who can view docs with `access API reference`.
- Restrict who administers projects with `administer API reference`.
- Add external/PHP branches for cross-project references.
- Queue large parses as background jobs.
- Embed navigation and search blocks on doc pages.
- Configure parsing behaviour on `/admin/config/development/api`.
- Filter or list services by tag in Views.
- Format DocBlock file-name and namespace fields.
- Build a public API portal like api.drupal.org.