<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# simple_popup_blocks — agent index

Turns any Drupal block, form, view, or custom `div` into a popup/modal by CSS selector. Each
popup is a standalone config object **`simple_popup_blocks.popup_<uid>`** (schema
`simple_popup_blocks.*`). No module dependencies; no default popup styling (you style it).
Config UI: **Admin → Config → Media → Add simple popup blocks**
(`/admin/config/media/simple-popup-blocks/add`, route `simple_popup_blocks.add`, permission
`administer simple_popup_blocks`). Manage/edit/delete at `…/simple-popup-blocks/manage`.

- The popup config object, every setting key + its integer enums (type, layout, trigger, frequency), and how to read/create/delete popups with drush → [configure/popups.md](configure/popups.md)
- How popups reach the page (`hook_page_attachments` → `drupalSettings` → JS), the JS/CSS library, generated CSS selectors, and the legacy DB table (dead code) → [api/api.md](api/api.md)

No Drush commands, no plugin types, no hooks-to-implement, no submodules.
