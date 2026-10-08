<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Blank Node Title lets editors leave a node's title blank; on save the module fills in a generated title so the required-title constraint no longer blocks content creation.

It works with two hooks: a `hook_form_node_form_alter` (via `Hook\FormNodeFormAlter`) that relaxes the title requirement on the node form for the configured content types, and a `hook_ENTITY_TYPE_presave` (via `Hook\NodePresave`) that, when the title is empty or just `-`, sets it to `"<content-type> - <long-formatted request time>"`. A settings form under Configuration → Content chooses which node types this applies to.

Typical setup: enable the module, open the settings form, tick the content types whose title should be optional, and save.

---

Short summary: allow blank node titles and auto-fill them from type + timestamp on presave.

It solves the friction of Drupal's mandatory node title for content types where a meaningful title isn't natural (log entries, imported items, journal-style content). It works purely through form-alter and presave hooks plus a small config form; there are no routes beyond the admin settings page.

Operationally: the only route is the admin config form (permission *administer site configuration*); behaviour is limited to node entities and to the content types selected in config. Note the module still references the deprecated `entity.manager` service in its settings form constructor, which may warn on newer core.

---

- Allow editors to save a node without typing a title.
- Auto-generate a title from the content type name and save time.
- Enable optional titles for specific content types only.
- Reduce friction when creating log- or journal-style content.
- Bulk-import nodes without supplying a title for each.
- Keep required-title validation off on the node add/edit form.
- Replace a placeholder `-` title with a generated one on save.
- Configure which node types get optional titles at `/admin/config/content/blank-node-title`.
- Give content types consistent fallback titles automatically.
- Avoid custom code to default node titles.
- Let quick-capture content types skip the title step.
- Format the generated title with the site's “long” date format.
- Restrict configuration to *administer site configuration* users.
- Turn the behaviour off per content type by unchecking it.
- Keep titles present for admin listings even when editors leave them blank.
