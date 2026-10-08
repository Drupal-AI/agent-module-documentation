Content First renders any node (or menu) as clean, layout-free text — Markdown or simplified HTML with optional YAML front matter — for content review, export, and LLM/mkdocs consumption.

---

Enabling the module adds a "Content First" tab to node pages (`/node/{node}/content-first`, permission `view content_first content` + node view access) that shows the stripped Markdown of the node's full view, a header outline built from H1–H6, and copy/download buttons. A parallel tab on menu edit forms (`/admin/structure/menu/manage/{menu}/content-first`, gated by `administer menu`) renders the menu tree as Markdown. Rendering is done by the `content_first.builder` service (`ContentFirstBuilderInterface::buildContent($entity, $view_mode)`), which uses `entity_render_context` to render the entity, removes configured CSS selectors (`symfony/css-selector`), converts to Markdown (`league/html-to-markdown`), and can prepend YAML front matter from selected entity properties, extra fields, and (with the Metatag module) chosen metatags. Global settings at `admin/config/content/content-first` (`content_first.settings`) control which entities/bundles are enabled, allowed metatags, markdown attributes, ignored selectors, entity properties/extra fields, and menu-link inclusion. The module exposes per-view-mode node tokens (`[node:content-first-markdown-<view_mode>]` and `[node:content-first-clean-<view_mode>]`). Two Drush commands export content to Markdown files (`content-first:export` / `cf:export`) and entity field architecture to YAML (`content-first:export-architecture` / `cf:architecture`), with options for Obsidian-style link rewriting and asset base URLs. The `content_first_audit` submodule adds automated heading/metatag auditing via Entity Registry. Controllers escape rendered output with `Html::escape`, and node access is enforced before building.

---

- View any node's content as clean Markdown, free of layout, media, and chrome.
- Review copy in a distraction-free interface during editorial sprints.
- Copy a node's Markdown to the clipboard with one click.
- Download a node's content as a Markdown or simplified-HTML file.
- Render a menu tree as Markdown for documentation or review.
- Add YAML front matter (title, description, abstract, …) to Markdown output for mkdocs/LLMs.
- Feed clean node content to an LLM as context via the `content-first-markdown-*` token.
- Include selected entity properties (id, type, status, langcode, created, …) as front matter.
- Include extra entity fields as front-matter attributes.
- Include chosen metatags (with the Metatag module) as front matter.
- Strip unwanted regions by CSS selector (e.g. `nav.pager`, `ul.contextual-links`).
- Export all nodes to per-page Markdown files with `drush cf:export`.
- Export only specific bundles, languages, or publish status to Markdown.
- Rewrite internal links to local filenames for an Obsidian import (`--rewrite-links`).
- Make asset (image/document) links absolute with `--assets-base-url`.
- Flatten nested front-matter keys for tools that lack nested YAML (`--flatten-properties`).
- Export menus to Markdown files (one per menu per language).
- Export entity field architecture as YAML with `drush cf:architecture` (optionally following references).
- Generate a documentation site source from Drupal content.
- Run pre-design content validation before layout work begins.
- Perform accessibility-oriented reading reviews of node content.
- Audit heading structure (H1 counts, hierarchy) across content via the audit submodule.
- Audit metatag presence/length across content via the audit submodule.
- Restrict who can view/export content-first output with the `view content_first content` permission.
- Produce a machine-readable content inventory for migration planning.
