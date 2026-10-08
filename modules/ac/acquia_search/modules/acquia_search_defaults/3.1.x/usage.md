<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Acquia Search Defaults is a turnkey submodule of Acquia Search that installs a ready-made Search API Solr index and a search Views display so a connected site has working content search out of the box.

---

Acquia Search Defaults ships only **optional config**, no code: a Search API index (`acquia_search_index`, "Acquia Search Solr Index") bound to the `acquia_search_server`, and a View (`views.view.acquia_search`) that renders results from it. The index datasource is `entity:node`, indexing Title, Body, content type, author, status and node-access grants, with sensible Solr processors pre-enabled (content access, highlighting/excerpts, HTML filter, type boosting). Because the files live in `config/optional`, they are imported when the submodule is enabled **only if** their dependencies (the `acquia_search_server` and the `node.body` field) already exist; otherwise enabling the submodule is a no-op for that config. It exists so you don't have to hand-build a first index and search page — enable it, connect your Acquia subscription, and index. Everything it creates is ordinary Search API config you can then edit or clone. It adds no settings, permissions, routes, or Drush commands of its own.

---

- Get a working Acquia Solr content index (`acquia_search_index`) without building one by hand
- Get a ready-made search results View (`views.view.acquia_search`) wired to that index
- Bootstrap node search (Title + Body + type + author + status) on a new Acquia-connected site
- Provide a starting point you clone/rename for a project-specific index
- Demo Acquia Search quickly in a proof-of-concept
- Ship a consistent default index across environments in a deploy pipeline
- Inherit pre-tuned Solr processors (highlighting, excerpts, HTML filter, content-access) with no manual setup
- Skip writing datasource/field/processor YAML for the common node-search case
- Index Title and Body text plus content type, author (uid), and published status for nodes
- Respect node access grants automatically (the `node_grants` field is indexed and locked)
- Get highlighted search excerpts (400-char excerpt with `<strong>` markers) with no extra config
- Get HTML stripping/boosting on indexed fields via the pre-enabled `html_filter` processor
- Use `content_access` and `entity_status` processors so unpublished/inaccessible nodes are filtered
- Attach the default index to the shared `acquia_search_server` in one step
- Enable it after connecting a subscription so the first index+view appear immediately
- Learn Search API index structure by reading a complete, working example config
- Leave it disabled and build a custom index instead when the node defaults don't fit
- Re-import the default index/view config after an accidental deletion by re-enabling the submodule
- Serve a basic keyword search results page to end users with zero View-building
