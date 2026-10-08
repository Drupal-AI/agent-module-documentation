<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
LLMs.txt Gen auto-populates the `llms.txt` file (via the LLMs.txt module) with sections that list every published node, grouped by content type, as markdown links to each node's `.md` URL.
---
The module provides an `LlmsTxtGenerator` service whose `generate()` method deletes all existing `llms_txt_section` entities, queries published nodes (optionally filtered by content type via an include/exclude mode), groups them by bundle sorted by label, sorts nodes alphabetically by title, and creates one `llms_txt_section` entity per content type containing markdown bullet links. Generation runs automatically on cron (`hook_cron`) and on install (which also creates a "LLMs.txt Raw" text format), and can be triggered manually with the Drush commands `llms-txt-gen:generate` (alias `llms-gen`) and `llms-txt-gen:delete` (alias `llms-del`).

Security is handled deliberately: because `/llms.txt` is served without authentication, the node query uses `accessCheck(FALSE)` for performance but then re-checks each node with `$node->access('view', new AnonymousUserSession())` before including it, so access-restricted content (including modules implementing only `hook_node_access()`) is not leaked to anonymous consumers. Node titles are escaped for markdown link text (`\`, `[`, `]`) to prevent link-injection into the public output. Configuration lives at `/admin/config/search/llms-txt-gen` (route gated by the `administer llms_txt_gen` permission) where an admin chooses "only selected" vs "all except selected" content types; if nothing is selected, all types are included.
---
- Auto-generate `llms.txt` sections from published nodes on cron.
- Group generated links by content type, sorted by label.
- Include only selected content types via the settings form.
- Exclude specific content types ("all except those selected" mode).
- Regenerate all sections manually with `drush llms-gen`.
- Delete all generated sections with `drush llms-del`.
- Expose site content to LLMs/AI crawlers via llmstxt.org format.
- Link each node to its `.md` (markdown) URL for machine reading.
- Keep the llms.txt current automatically as content is published.
- Ensure only anonymously-viewable nodes are listed (per-entity access check).
- Prevent markdown link injection from node titles (escaping).
- Configure inclusion at `/admin/config/search/llms-txt-gen`.
- Restrict configuration with the `administer llms_txt_gen` permission.
- Run an initial generation automatically on module install.
- Use the auto-created "LLMs.txt Raw" text format for section content.
- Sort node links alphabetically by title within each type.
- Integrate with the LLMs.txt and Markdownify modules.
- Rebuild sections after bulk content imports via Drush.
- Schedule regeneration frequency by adjusting cron.