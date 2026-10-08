Paragraphs View Modes adds a Paragraphs **behavior plugin** that lets an editor choose, per individual paragraph, which view mode that paragraph is rendered with — without creating separate paragraph types.

---

The module ships a single Paragraphs behavior plugin, `paragraphs_viewmode_behavior`, that you enable on a paragraph type from its edit form (Behaviors section). In the behavior's plugin settings you pick three things: which view mode to *override* (`override_mode`), which view modes an editor is *allowed* to switch to (`override_available`), and the *default* view mode (`override_default`). Those settings are stored on the `paragraphs.paragraphs_type.<type>` config entity under `behavior_plugins.paragraphs_viewmode_behavior`. When editing a paragraph of that type in the (experimental/EXPERIMENTAL) paragraphs widget, a "Select which view mode to use for this paragraph" dropdown appears, limited to the allowed modes; the chosen mode is saved as a per-paragraph behavior setting (`view_mode`) on the paragraph entity. At render time the module implements `hook_entity_view_mode_alter()`: for each paragraph it calls the enabled behavior plugin's `entityViewModeAlter()`, which swaps the active view mode for the one the editor picked when the requested mode matches the configured override target. The result is that one paragraph type can be shown with different layouts or field sets on a case-by-case basis. The module has no settings form, no configure route, no permissions, and no Drush commands — its only configuration is the behavior plugin settings on each paragraph type.

---

- Let editors render an individual "Card" paragraph in a "Wide" view mode while the rest use the default.
- Offer a per-paragraph "Featured" vs "Compact" display choice without duplicating a paragraph type.
- Allow a single "Image" paragraph to switch between "Full width" and "Thumbnail" layouts inline.
- Give content authors control over which fields show on a given paragraph by switching view modes.
- Avoid creating near-duplicate paragraph types that differ only in their display.
- Provide a "Teaser" display option on a "Quote" paragraph for use in sidebars.
- Let a "Columns" paragraph be rendered in a stacked mode on some pages and a grid mode on others.
- Enable an editorial "Highlight" mode for call-to-action paragraphs on landing pages.
- Restrict the switchable view modes so editors can only pick from an approved subset.
- Set a sensible default view mode that new paragraphs of a type start with.
- Reuse the same paragraph fields across multiple visual presentations.
- Support A/B style presentation variations of the same content block.
- Give a "Media" paragraph an optional "No caption" view mode.
- Let a marketing team choose display variants without a developer changing templates.
- Configure the override entirely through exported config (`behavior_plugins.paragraphs_viewmode_behavior`) for deployment.
- Present a promotional paragraph in a "banner" mode on the front page and "inline" mode elsewhere.
- Reduce the number of view-mode-specific templates by consolidating into one paragraph type.
- Let a "Text" paragraph switch to a "Pull quote" view mode for emphasis.
- Allow per-instance display tuning within Layout Paragraphs / nested paragraph structures.
- Standardize which display options are available across content types via the allowed-modes list.
- Empower editors to control layout density (compact vs spacious) per paragraph.
- Add a per-paragraph "Print" or "Email" oriented view mode option.
- Support seasonal or campaign display variants using extra view modes on one paragraph type.
- Keep stored paragraph data identical while varying only the rendered display.
- Migrate existing sites toward per-paragraph display flexibility without restructuring content.
