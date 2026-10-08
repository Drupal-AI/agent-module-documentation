# LocalGov Page Components — agent index

Relabels Paragraphs library as "Page components" and adds a reusable node field + LinkIt
integration. No settings page (`configure` null), no permissions, no config schema, no Drush.
Depends on entity_browser, inline_entity_form, linkit, paragraphs (paragraphs_library).

- **The node field, Entity Browser, LinkIt setup, and the relabelling constants** →
  [configure/setup.md](configure/setup.md)
- **The two LinkIt plugins (Page components matcher + URL substitution) and how to extend them** →
  [plugins/linkit.md](plugins/linkit.md)

Submodule (own docs):
- `localgov_page_components_workflow` →
  [../../modules/localgov_page_components_workflow/1.4.x/agent/start.md](../../modules/localgov_page_components_workflow/1.4.x/agent/start.md)

Key facts:
- Field: `node.localgov_page_components`, entity_reference → `paragraphs_library_item`,
  cardinality -1, translatable. Installed by `config/install/field.storage.node.localgov_page_components.yml`.
- Entity Browser `page_components` (modal, `config/optional/`) has two widgets: a `view`
  (`paragraphs_library_browser`) to select and an `entity_form` to create.
- LinkIt plugins live in `src/Plugin/Linkit/Matcher/PageComponentMatcher.php` and
  `src/Plugin/Linkit/Substitution/ParagraphsLibraryItem.php`.
