<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Node Alias Link Display rewrites `/node/123`-style links in WYSIWYG and rendered content to their path aliases.

---

Editors insert links to internal content and, depending on how they do it, end up with `/node/123` in the markup. That works — Drupal resolves it — but it publishes an internal identifier, produces an unreadable URL when shared, and means a link that does not benefit from the descriptive alias the site went to the trouble of generating.

This module rewrites those links at display time, so stored content keeps whatever the editor put in while what visitors see is the alias.

Doing it at display rather than on save is the right choice, and worth understanding. The stored `/node/123` is the stable reference: it keeps working if the alias changes, whereas markup rewritten on save would break. Rewriting on output gets the readable URL without giving up that stability.

Two things to check. **The alias is resolved at render time**, so a page holding many internal links does that lookup per link — usually fine, worth knowing on a heavily linked page behind no cache. And the rewrite touches rendered output, so anything else altering links in the same pipeline should be checked for interaction, particularly modules that add tracking parameters or handle language prefixes.

---

- Show a path alias instead of /node/123.
- Publish readable internal URLs.
- Avoid exposing node ids in markup.
- Improve shared link readability.
- Keep stored links stable when aliases change.
- Benefit from generated aliases in body text.
- Rewrite links at display time.
- Avoid rewriting stored markup.
- Check interaction with language prefixes.
- Check interaction with link-tracking modules.
- Consider lookup cost on link-heavy pages.
- Improve SEO of internal linking.
- Audit content containing raw node links.
- Migrate a site to alias-based linking.
- Document the rewriting behaviour for editors.
- Verify links after an alias change.
