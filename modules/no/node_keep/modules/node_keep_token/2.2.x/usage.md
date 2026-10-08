Node Keep Service & Tokens lets you give a Node Keep–protected node a stable machine name and then reference that node's alias, id, url or uri anywhere via `[node-keep:<machine_name>:…]` tokens.

---

This submodule of Node Keep adds a `keeper_machine_name` string base field to every node, shown in the node form's "Node keep" section but only when the node is protected (`node_keeper` checked). The machine name must be unique and match `[a-z0-9_]+` (validated on save). For each protected node that has a machine name, the module registers tokens under the `node-keep` token type: `[node-keep:<machine_name>:alias]`, `:id`, `:url` and `:uri`, letting you refer to important nodes by a stable name rather than a hard-coded node id (which can differ between environments). It also exposes a service, `node_keep_token.helper` (`NodeKeepTokenService`), with helper methods to load protected nodes by machine name, list them as options, check machine-name uniqueness, and fetch a protected node (with translation fallback). Changing the machine name requires the `administer node_keep_token per node` permission. Because it builds on Node Keep, the referenced nodes are also protected from accidental deletion, so the tokens keep resolving.

---

- Reference a site's homepage node as `[node-keep:home:url]` instead of a fragile `/node/12`.
- Link menus, blocks or body text to a key landing page by machine name, environment-independent.
- Build a breadcrumb or CTA that points at a "contact" node via `[node-keep:contact:alias]`.
- Give a section-overview node a machine name and reuse its URL across many child pages.
- Keep cross-environment references stable when node ids differ between dev/stage/prod.
- Insert a protected node's alias into an email or message template through tokens.
- Look up a protected node in code by machine name with `getProtectedNodeByMachineName('home')`.
- Populate a select list of protected nodes using `getProtectedNodesAsOptions()`.
- Enforce unique, code-safe machine names for editorially important nodes.
- Expose a node's canonical URL to another module via the `node_keep_token.helper` service.
- Ensure token-referenced nodes can't be deleted (protection is inherited from Node Keep).
- Render `[node-keep:privacy:uri]` (e.g. `node/34`) where an internal URI is needed.
- Let site builders reference anchor nodes without editing code when ids change.
- Provide a machine-name → node map for custom integrations (`getProtectedMachineNames()`).
- Reserve human-friendly identifiers for a handful of pillar pages.
- Drive a "featured page" region from a machine-named protected node.
- Use tokens in Pathauto patterns or other token-aware fields to reference pillar nodes.
- Guarantee a token only resolves for genuinely protected (node_keeper) nodes.
- Migrate hard-coded node links to stable machine-name tokens.
- Fetch the current-language translation of a protected node by machine name for output.
