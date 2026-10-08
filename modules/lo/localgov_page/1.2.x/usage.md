<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
LocalGov Page provides the `localgov_page` node type — the LocalGov Drupal general-purpose page for building rich, structured content from Paragraphs and Layout Paragraphs.
---
The module is almost entirely configuration: it installs the `localgov_page` content type, its fields (`localgov_paragraph_content`, `localgov_page_summary`, `localgov_page_banner`, `localgov_hide_summary`), field group layout, and default/full/teaser/search view displays. The only PHP is a `hook_preprocess_node` that, on the full view of a `localgov_page`, removes the summary from the rendered output when the node's `localgov_hide_summary` boolean is set — a purely display-side toggle. Rich content is authored through the Paragraphs/Layout Paragraphs stack and the LocalGov paragraph library (`localgov_paragraphs*`).

There is no custom routing, no permissions file, no services and no controllers — access to `localgov_page` nodes is governed entirely by core node access and the standard node permissions. Setup is simply enabling the module (which pulls in the Paragraphs/LocalGov dependency stack) and then creating/curating `localgov_page` nodes; site builders can extend the content type through the normal Field UI and Layout Paragraphs configuration.
---
Create a LocalGov page node.
- Build page layouts with Layout Paragraphs.
- Add rich paragraph content blocks to a page.
- Set a page summary field.
- Hide the summary on the full page view via the toggle.
- Add a banner to a page.
- Use the page as a microsite landing page.
- Add the page to a menu (menu_ui).
- Reference LocalGov media in page paragraphs.
- Extend the content type with custom fields via Field UI.
- Configure the full/teaser/search view displays.
- Group fields with field_group in the edit form.
- Curate paragraph ordering within a page.
- Use LocalGov paragraph types (localgov_paragraphs) in pages.
- Grant standard node permissions to page editors.
- Index page content for search via the search_index display.