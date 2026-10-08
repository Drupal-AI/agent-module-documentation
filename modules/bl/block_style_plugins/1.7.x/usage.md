Block Style Plugins is an API module that lets a module or theme add custom style configuration (extra form fields, CSS classes, template suggestions) to the block configuration form via a `BlockStyle` plugin.

---

The module defines a `BlockStyle` plugin type (manager `plugin.manager.block_style.processor`, annotation `@BlockStyle`, base class `BlockStyleBase`). Plugins are discovered two ways: as PHP classes in a module/theme's `Plugin/BlockStyle` namespace, or declaratively from a `MYMODULE.blockstyle.yml` / `MYTHEME.blockstyle.yml` file (via a `YamlDiscoveryDecorator`) — the YAML route is the easy path and works in themes where annotations aren't scanned. On the block config form (`block_style_plugins_form_block_form_alter`), every plugin's `prepareForm()` injects its fields into a "Block Styles" fieldset and stores the values as block third-party settings under `block_style_plugins`. Each plugin can restrict itself to certain blocks with `include`/`exclude` lists (block plugin id, `base_id:*` derivative wildcard, or block content bundle). At render time (`hook_preprocess_block`) each plugin's `build()` adds the saved values to the block's `attributes.class`, and `themeSuggestion()` can add a template suggestion. Values are stored as an opaque sequence (`block.settings.block_style_plugins`, schema type `ignore`). Depends on core `block` and `block_content`; there is no admin UI or settings page of its own, no permissions and no Drush.

---

- Add a "CSS class" textfield to the block config form so editors can style individual block placements.
- Provide a dropdown of preset style variants (e.g. "Card", "Highlighted", "Bordered") for blocks in a theme.
- Add checkboxes that toggle utility classes on a block (e.g. `text-center`, `shadow`).
- Restrict a style option to only certain block content bundles with an `include` list.
- Exclude specific block plugins (e.g. system branding) from a style option with `exclude`.
- Target all derivatives of a block plugin with a `base_id:*` wildcard in include/exclude.
- Define block styles entirely in a theme via a `mytheme.blockstyle.yml` file with no PHP.
- Ship reusable block styles from a module using a `mymodule.blockstyle.yml` file.
- Build advanced, stateful style options in PHP by extending `BlockStyleBase`.
- Add a custom Twig template suggestion per block via a plugin's `template:` key or `themeSuggestion()`.
- Auto-apply saved style values as classes on the block wrapper via the `block_styles` fieldset convention.
- Let editors add a background-color or layout modifier class to a specific block instance.
- Give a "Basic block" content type a bespoke set of style controls keyed to its bundle machine name.
- Provide per-block spacing/margin utility selectors surfaced only on layout blocks.
- Add a "hide on mobile" checkbox that maps to a responsive utility class.
- Keep block styling as block config (third-party settings) so it exports with the block via config management.
- Offer theme-specific style palettes that change when the active theme changes.
- Supply a select of heading styles for menu/title blocks.
- Add a plugin whose fields only appear on blocks placed in a particular region-targeted block plugin.
- Let site builders assign BEM-style modifier classes without touching CSS/templates.
- Combine multiple BlockStyle plugins on one block, each contributing its own fieldset of options.
