<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds configurable, toggleable help text to fields, blocks and views so editors get inline guidance while creating content.

---

The module provides admin-configured help strings and per-field help. A settings form at `/admin/config/content/editing_helper/config` (`HelpDescriptionConfigForm`, permission `administer editing helper permissions`) stores default help text in `editing_helper.help_config` for several contexts: inline vs reusable block content, view field text, and node/taxonomy view text. Separately, a `hook_form_field_config_edit_form_alter` adds an "Editing Helper Description" textarea to each field's config form, storing per-field help as a field third-party setting. A Views `display_extender` plugin lets a view carry its own help description. At render time, `hook_preprocess_block()` inspects the block's plugin id (block_content / field_block / views_block), picks the most specific help text available, and — only for users with the `access to editing helper` permission — injects a toggle button and a help panel (theme hook `help_content`) above the block.

Operationally there are two permissions: `administer editing helper permissions` (configure the help text) and `access to editing helper` (see the help affordance). The help content is authored by administrators through config/field settings — i.e. a trusted input surface — and is shown to editors; it is not user-submitted content. The config route is permission-gated and there are no anonymous or mutating endpoints. Because help text may contain HTML authored by admins, treat it as a trusted-role responsibility (standard for admin-entered markup).

---
- Show editors inline help while filling in a field
- Add per-field instructions via the field config form
- Configure default help text for inline block content
- Configure help text for reusable block content
- Provide help text on view-based blocks (node/taxonomy)
- Add a help description to a specific view via the display extender
- Give editors a toggle button to reveal instructions
- Restrict who sees help with the access permission
- Restrict who configures help with the admin permission
- Standardize content-entry guidance across a site
- Reduce onboarding time for new content editors
- Document formatting expectations next to a field
- Show reusable vs inline block guidance appropriately
- Provide HTML-formatted help content for rich instructions
- Label the help block title via configuration
- Attach help affordances to field_block placements
- Keep instructions consistent across content types
- Configure all help text from one settings form
