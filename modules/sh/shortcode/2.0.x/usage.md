<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Shortcode brings WordPress-style `[tag]...[/tag]` markup to Drupal text formats: enable its `shortcode` text filter on a format and any square-bracket tags in the field are expanded into HTML by pluggable "Shortcode" plugins at render time.

---

The module is a filter framework plus a plugin type, not a fixed set of tags. It defines an `@Shortcode` annotation plugin type (discovered from `Plugin/Shortcode` in any module, managed by the `plugin.manager.shortcode` service) and a `ShortcodeService` that recursively parses `[tag attr="val"]content[/tag]` and self-closing `[tag /]` markup out of filtered text, matching each tag's **token** (defaults to its plugin **id**) against enabled plugins and calling that plugin's `process()` method to produce replacement HTML. The actual tags come from other modules — the module ships no shortcodes itself; `shortcode_basic_tags` and `shortcode_example` (and any custom module) supply them. Enabling happens on a per-text-format basis via the `shortcode` filter plugin (`@Filter`, `TYPE_TRANSFORM_IRREVERSIBLE`); the filter's settings form lists every discovered shortcode plugin with a checkbox, and unchecked tags are left as literal text. A second filter, `shortcode_text_corrector`, cleans up stray `<p>`/`<div>` wrapping that WYSIWYG editors (e.g. CKEditor) insert around block-level shortcodes. There is no configuration UI, no permissions, and no Drush commands — everything lives in text-format filter configuration and in the shortcode plugins themselves.

---

- Add `[quote author="..."]...[/quote]`-style WP shortcodes to a Drupal text format without a custom module.
- Enable the `shortcode` filter on Basic HTML / Full HTML (or a custom format) to turn on bracket-tag parsing.
- Selectively enable or disable individual shortcodes per text format via `filter_settings.shortcode`.
- Write a custom `@Shortcode` plugin to expose a reusable, editor-facing content snippet (e.g. a callout box).
- Give content editors a lightweight, non-technical way to embed styled markup (buttons, quotes, columns) in body text.
- Migrate content authored with WordPress shortcodes into Drupal without rewriting the markup by hand.
- Use `shortcode_text_corrector` to fix `<p>`/`<div>` nesting CKEditor injects around block-level shortcode tags.
- Build a "Bootstrap column" shortcode (see `shortcode_example`) so editors can lay out multi-column text without touching HTML.
- Ship a set of ready-made tags (highlight, dropcap, button, quote, image, link, block, etc.) via `shortcode_basic_tags`.
- Provide a `[block id="123"]` shortcode so editors can embed a custom block instance inline in body text.
- Let editors self-close a tag (`[img src="..." /]`) for shortcodes that render without wrapping content.
- Nest shortcodes inside one another (e.g. a `[quote]` inside a `[block]`) since the parser processes tags recursively.
- Group shortcode settings-form checkboxes by the module ("provider") that defines them, for easier admin review.
- Allow content authors to escape a literal `[tag]` from being processed by doubling the brackets (`[[tag]]`).
- Read a shortcode's inline help ("tips") text shown under the text-format's "more information about text formats" link.
- Weight shortcode plugins so that if two plugins share the same token, the higher-weighted one wins.
- Give each shortcode a default enabled/disabled state (`status` annotation property) independent of admin choice.
- Pass default settings from a shortcode's `@Shortcode(settings = {...})` annotation into its plugin instance.
- Support alternate token strings distinct from the plugin id (e.g. plugin id `foo`, parsed token `bar`).
- Build config-managed text formats (`filter.format.<name>.filters.shortcode`) that ship shortcode enablement as exportable config.
- Provide an extensible alternative to hard-coding embed markup directly in body-field HTML.
- Allow themes/modules to alter discovered shortcode plugin definitions via `hook_shortcode_info_alter()`.
- Combine shortcode tags with core filters (URL filter, HTML corrector) in the same text format's filter pipeline.
- Let a shortcode plugin render a block, a media image, or other entity content inline in a text field.
- Offer editors a `[random length="8"]` style utility shortcode for placeholder/test content.
- Migrate a Drupal 7 site's `shortcode_text_corrector` filter configuration forward via the module's migration plugin alter.
