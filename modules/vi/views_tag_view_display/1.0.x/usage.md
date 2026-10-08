<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
views tag views display is a Views display extender that lets you attach arbitrary comma-separated tags to any view display and read them back through a service, so code can discover displays by tag.
---
Enabling the module registers the `views_tag_view_display` display extender in `views.settings` (added on install, removed on uninstall). The extender plugin (`ViewsTagViewDisplayExtender`) adds a "Views display tags" section to each display's settings with a textarea where you enter tags separated by commas; the value is stored in the display's options and summarised in the display's options list. It contributes nothing to the query itself — it is purely metadata carried on the display.

A companion service, `views_tag_view_display.tags` (`ViewsTagViewDisplayTagsService::getList($view_name, $display_id)`), loads a view, initialises the given display, reads the extender's stored value and returns it as an exploded array of tags (empty array when the view/display/extender is missing). This gives modules and themes a cheap way to group or select displays — e.g. rendering every display tagged "sidebar" — without hardcoding view/display ids.

Setup: enable the module (the extender is activated automatically), edit a view, open a display's advanced settings, add tags in the "Display view Tags" field, and save. Consume the tags in custom code via the service.

---

- Tag a Views display with comma-separated labels
- Add arbitrary metadata tags to any view display via the extender
- Discover displays by tag programmatically through the service
- Group related displays under a shared tag
- Read a display's tags with views_tag_view_display.tags::getList()
- Render every display tagged 'featured' without hardcoding ids
- Categorize block displays for theme/module logic
- Store tags in the display options without affecting the query
- Enable the display extender automatically on module install
- Author tags in the Views UI advanced settings
- Summarize a display's tags in the Views options list
- Select displays for custom rendering based on tags
- Build a tag-driven directory of view displays
- Avoid hardcoding view/display ids in custom code
- Return an empty array safely when a view/display/extender is missing
- Remove the extender cleanly on uninstall
