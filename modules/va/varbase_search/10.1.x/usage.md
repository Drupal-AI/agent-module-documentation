<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Varbase Search supplies the search configuration for a Varbase site: a Search API database server, a cron indexing job, and an install recipe that enables the core search stack and opens search to all users, rather than leaving each project to assemble it.

---

Search API is powerful and unopinionated — it gives you indexes, servers, processors, datasources and views and expects you to decide how they fit together. That flexibility is the right default for the module and the wrong starting point for a distribution, where every site wants roughly the same thing. Varbase Search makes the decision once. Its `hook_install()` runs a bundled recipe (`recipes/default`) that installs `search`, `search_api` and `search_api_db`, imports a database-backed Search API server (`search_api.server.database_server`, backend `search_api_db`, partial matching, minimum three characters) and an Ultimate Cron indexing job, and grants the `search content` permission to anonymous and authenticated users. It also adds a hook to the Manage-display form: when a content type turns on a custom `search_result` view mode, the module writes a ready-made Display-Suite/Field-Group search-result layout for that bundle from a bundled template. The concrete content index, the `search_content` view at `/search` and the search-box block are provided by the Varbase distribution and mirrored in the module's test fixture, not in the module's own install config. Composer requirements are lean for the Varbase family — `search_api ~1`, `vardot/module-installer-factory ~1` and core — and `core_version_requirement` is pinned to `~11.4.0`. Because the server and cron config live in `config/optional`, they apply only when their backing modules are present, so the module degrades rather than failing.

---

- Get a working Search API server on a Varbase site without configuring it by hand.
- Ship a database-backed search backend with a new site.
- Enable the core `search`, `search_api` and `search_api_db` modules together via one recipe.
- Grant search access to anonymous and authenticated users out of the box.
- Provide an Ultimate Cron job to index content on schedule.
- Auto-generate a `search_result` node display when a content type opts in.
- Standardise the search-result layout across content types with a shared template.
- Give editors a preconfigured search server rather than a blank Search API install.
- Provide a consistent search backend across a Varbase estate.
- Reduce project setup time for site search.
- Keep the search server and cron config exportable as YAML.
- Re-apply search configuration from a recipe.
- Bootstrap search config before content exists.
- Support a multi-site rollout with shared search backend config.
- Swap the database backend for Solr by editing one server config.
- Use partial-match, three-character-minimum database search defaults.
- Serve the distribution's `/search` page and search-box block from the shipped server.
- Avoid bespoke Search API decisions per project.
- Set the module weight after install so its hooks run after the search stack.
- Add the core search stack to an existing Standard or Minimal site.
