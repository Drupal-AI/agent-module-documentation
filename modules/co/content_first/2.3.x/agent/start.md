# Content First — agent index

Renders nodes and menus as clean Markdown / simplified HTML (optionally with YAML front matter)
for review, export, and LLM/mkdocs use. Adds a node tab and a menu tab, a settings form
(`configure: content_first.config`), tokens, and two Drush export commands. Depends on core `node`
and contrib `entity_render_context`; uses `league/html-to-markdown` + `symfony/css-selector`.
Main module defines no plugin type (the `content_first_audit` submodule does).

- **Settings (`content_first.settings`): entities/bundles, metatags, selectors, front matter** →
  [configure/settings.md](configure/settings.md)
- **`content_first.builder` service + `RenderedContent` + the node tokens** →
  [api/service.md](api/service.md)
- **Drush `cf:export` (Markdown) and `cf:architecture` (field YAML)** →
  [drush/commands.md](drush/commands.md)

Submodule (own docs):
- `content_first_audit` → [../../modules/content_first_audit/2.3.x/agent/start.md](../../modules/content_first_audit/2.3.x/agent/start.md)

Key facts:
- Node tab route `content_first.content_first_node` (`/node/{node}/content-first`): permission
  `view content_first content` **and** `_entity_access: node.view` **and** the custom
  `_content_first_entity_access` check (entity/bundle enabled in config). `NodeController::build`
  also re-checks `$node->access('view')`.
- Menu tab route `content_first.menu`: permission `administer menu`.
- ZIP download route `content_first.download_zip` (`view content_first content`): streams a file
  named in the caller's **private** tempstore, validated by regex + basename + temp-dir realpath
  containment (path-traversal guarded).
- Permissions: `view content_first content`, `administer content_first` (neither marked
  `restrict access`; the second gates the settings form + audit-clear).
- Rendered output is `Html::escape`d in the controllers before display.
