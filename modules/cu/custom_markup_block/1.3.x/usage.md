<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Custom Markup Block adds one block plugin, "Custom Markup", whose body is a filtered text area stored in the block instance's configuration rather than in a content entity, so a snippet of HTML deploys with `drush cim` and is version-controlled instead of being recreated per environment.

---

The module is deliberately small: a single `CustomMarkup` block plugin extending `BlockBase`, plus a config schema. You place the block anywhere blocks can go (Block layout, Layout Builder, Page Manager), enter markup into a `text_format` element that lets you pick a text format, and the block renders that value through `#type: processed_text` with the chosen format applied. Because the content is block configuration (a `block.block.*` config entity keyed under `block.settings.custom_markup` with `markup.value` and `markup.format`), it exports and imports with the rest of your site config — which is the whole point: this is for markup the codebase owns (a legal notice, an embed wrapper, a structural fragment) rather than content editors should manage. The default format is `full_html`, the only dependency is core `filter`, there is no settings page, and the core requirement is a wide `^8 || ^9 || ^10 || ^11`. The trade-off is the usual one for config-stored content: a config import overwrites whatever was changed on that environment, and the optional `token_filter` module can add token replacement as an input filter on the chosen format.

---

- Ship a markup snippet as configuration.
- Deploy block HTML through config import.
- Version-control a legal notice or disclaimer.
- Keep a markup block identical across environments.
- Review markup changes in a merge request.
- Avoid recreating custom blocks after a database refresh.
- Place a structural HTML fragment in a region.
- Roll back markup with a config revert.
- Keep developer-owned markup out of content.
- Add a wrapper for a third-party embed script.
- Provide a fixed copyright or attribution block.
- Add a simple markup block inside a Layout Builder layout.
- Ship markup with an install profile.
- Export block markup with site config (`drush cex`).
- Render markup under a chosen text format.
- Distribute the same block across a multisite.
- Prevent editors changing a controlled snippet.
- Add a button or call-to-action block without a custom module.
- Insert tokens into block markup via Token Filter.
- Add markup to a block without creating a content entity.
