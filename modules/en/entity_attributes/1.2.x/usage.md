Entity Attributes gives site builders a single UI for adding HTML attributes (id, class, data-*, ARIA, etc.) to many entity types and passes them to the entities' Twig templates.

---

Entity Attributes adds an "Attributes" field, edited as YAML, to the edit forms of nodes, taxonomy terms, content menu links, static (module-defined) menu links, blocks, menus, paragraphs and ECK entities. Support for each entity type/bundle is turned on from one settings page, and the stored attributes are merged into the matching template variables (attributes, title_attributes, content_attributes, link_attributes, author_attributes, and any plugin-defined set) during preprocessing, so themers can print them with `{{ attributes }}`-style tags. It is built entirely on core APIs: content entities store attributes in a locked `entity_attributes` string_long field; config entities (blocks, menus) store them in third_party_settings; static menu link attributes live in a dedicated config object. The system is plugin-based (one EntityAttributes plugin per entity type) so additional entity types can be supported by adding a plugin. An optional CodeMirror editor gives YAML syntax highlighting when the CodeMirror Editor module is present.

---

- Add a CSS class to a single node so a theme can style it differently.
- Give a specific block a stable HTML `id` to use as an in-page anchor target.
- Attach `data-*` attributes (e.g. `data-toggle`, `data-target`) to an element for a JS library or modal.
- Add ARIA attributes (`role`, `aria-label`) to a content wrapper for accessibility.
- Highlight one link in a menu by adding a class to that menu link only.
- Add `link_attributes` (e.g. `target`, `rel`) to a content or static menu link.
- Tag a taxonomy term's rendered markup with attributes for term-specific styling.
- Add attributes to individual paragraph items for component-level theming.
- Attach attributes to ECK entities without writing custom preprocess code.
- Set `title_attributes` to style only a node's or block's title element.
- Set `content_attributes` on the content wrapper of a node, block or menu.
- Replace several single-purpose modules (Block Class, Menu Attributes, Node Class, etc.) with one consistent tool.
- Enable attributes only on the specific bundles that need them, per entity type.
- Add attributes to module-defined static menu links (not just user-created ones).
- Give editors a per-bundle permission so only chosen roles can edit attributes.
- Add classes to trigger animation or behavior libraries on selected elements.
- Provide semantic wrappers (roles, landmarks) without creating custom templates.
- Store attribute configuration in exportable Drupal config for blocks, menus and static links.
- Use YAML validation so malformed attribute input is caught on save.
- Turn on CodeMirror syntax highlighting for the attributes field.
- Merge configured attributes into attributes core already provides on an element.
- Prototype markup tweaks quickly without touching theme template files.
- Add an anchor id and utility classes to a block placed in a region.
- Apply consistent attribute management across content, config and custom entities.
- Remove attribute fields cleanly (with a confirmation step) when a bundle no longer needs them.
