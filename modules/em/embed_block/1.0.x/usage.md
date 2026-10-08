<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Embed Block lets editors drop a block into body text with a `{block:plugin_id}` placeholder, which a text filter replaces with the rendered block — access-checked against the current user.

---

The whole module is one filter plugin. `EmbedBlockFilter::process()` scans the text for `{block:...}` with the regex `/{block:(?<plugin_id>[^}].*)}/`, and for each distinct match instantiates that block plugin through `plugin.manager.block`, checks `$block_plugin->access($this->currentUser)`, renders it and substitutes the markup for the placeholder. Three behaviours are deliberate: a block the user cannot access is replaced with an **empty string** rather than left as a visible placeholder; an unknown plugin id throws `PluginException`, which is caught and the placeholder is left untouched; and repeated placeholders for the same plugin are processed once and replaced everywhere. The plugin is added as a cacheable dependency of the filter result. Because it is an ordinary text filter, it is enabled per text format at `/admin/config/content/formats`, which is also the control over who can use it — anyone who can write in a format with the filter enabled can embed any block plugin the *viewer* is allowed to see. The installed release is `8.x-1.0-alpha4`; test it before relying on it in production.

---

- Embed a "recent content" block halfway down a page.
- Place a call-to-action block inside an article body.
- Insert a views block into rich text without Layout Builder.
- Let editors position a block precisely within prose.
- Reuse an existing block plugin inside content.
- Embed a menu block in a landing page body.
- Add a search form block into a help page.
- Insert a custom block plugin provided by a module.
- Keep block markup out of the editor's HTML.
- Show a block only to users who can access it, transparently.
- Avoid building a custom CKEditor plugin for a simple embed.
- Standardise embeds via a documented placeholder syntax.
- Combine embedded blocks with normal body content.
- Embed the same block twice in one page efficiently.
- Provide editors a lightweight alternative to paragraphs.
- Include a contact block at the end of every guide page.
- Insert a language switcher into a specific page.
- Add a promotional block to selected articles only.
- Keep the placeholder visible when a plugin id is wrong, aiding debugging.
- Enable the feature per text format for controlled rollout.
