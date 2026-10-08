<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Droost Wiki is the substrate for an agent-maintained codebase wiki: an OKF markdown bundle with per-page provenance, a Drush staleness report, and read-only MCP tools that serve generation fact sheets and the bundle.

---

Droost Wiki lets an AI agent build and maintain a codebase wiki. The wiki is an OKF (open knowledge format) markdown bundle stored at a configurable project-relative path (default `docs/wiki`), where each page carries a provenance manifest recording which source files it covers and their content hashes. A Drush staleness report (`drush droost:wiki:status`) classifies each page as fresh, stale (a covered file changed), orphaned (a covered file was deleted), invalid (malformed provenance) or unmanaged (no provenance), and lists custom modules no page covers — the wiki work list. Three read-only MCP tools serve the workflow: `droost_wiki_factsheet` (the generation packet for one module — what an agent needs to write or refresh its page), `droost_wiki_pages` (list pages, read one bundle-relative `.md` page, or grep across pages; every read is PathGuard-contained and byte-capped at 16 KB), and `droost_wiki_status` (per-page freshness). Page composition and generation (`PageComposer`, `WikiGenerator`, optionally AI-assisted) and the status report are driven from Drush; the MCP tools are read-only. It provides a settings form, config schema, and services for hashing, frontmatter parsing, bundle reading and provenance. It depends on the Droost base module and is for local/trusted development only.

---

- Maintain a markdown codebase wiki an AI agent can read and refresh.
- Store the wiki as an OKF bundle at a configurable project-relative path (default `docs/wiki`).
- Record per-page provenance: which source files a page covers and their content hashes.
- Run `drush droost:wiki:status` to see which pages are stale/orphaned/invalid/unmanaged.
- Get the list of custom modules no wiki page covers yet.
- Read one bundle-relative `.md` page over MCP (path-contained, 16 KB cap, truncation marker).
- List all wiki pages over MCP.
- Grep across wiki page content over MCP.
- Fetch the generation fact sheet for one module (what to write its page from).
- Check per-page freshness before regenerating.
- Generate or refresh a page from Drush (`drush droost:wiki:generate`), optionally AI-assisted.
- Author a page manually and have provenance track it.
- Keep the wiki bundle at the project root, not inside the web-accessible docroot.
- Configure the bundle path and toggles via the settings form (`administer droost wiki`).
- Give an agent a durable, provenance-checked knowledge layer over the codebase.
