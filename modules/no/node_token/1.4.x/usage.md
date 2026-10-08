<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Node Token gives every node bundle its own token type — `[node-article:…]`, `[node-page:…]` — instead of one generic `[node:…]` type, so token pickers show only the fields that actually exist on that content type.

---

The module is a single `.tokens.inc` file implementing two hooks. `hook_token_info_alter()` loads every `node_type` entity and, for each bundle, clones the generic `node` token type into a new type named `node-{bundle}`, labelled with the content type's name and described with its description. It then prunes the cloned token list: fields that exist on `node` in general but **not** on that bundle are removed with `array_diff_key()`, so an editor configuring a pathauto pattern or an email template for Articles no longer sees tokens for fields that only exist on Pages. Field tokens are resolved through `token.entity_mapper` to make sure a token type exists for the referenced entity before being offered, and reference fields are walked via the typed-data definitions. The second hook, `hook_tokens()`, performs the replacement by simply handing the node back to the standard `node` token handlers, so the underlying values come from the Token module exactly as before. The result is purely a discovery/UI improvement, but on a site with many content types and many fields it turns an unusable token browser into a usable one. There is no configuration, no permissions, no schema and no Drush.

---

- Show only the relevant tokens when configuring a pathauto pattern for one content type.
- Give editors a per-content-type token browser instead of one giant list.
- Avoid offering Page-only fields when editing an Article template.
- Build per-bundle email templates with accurate token lists.
- Reduce editor confusion about which tokens will resolve.
- Document available tokens per content type automatically.
- Keep token discovery correct as fields are added to a bundle.
- Use bundle-specific tokens in metatag configuration.
- Configure scheduler or workflow messages per content type.
- Provide accurate tokens for a bundle-specific view.
- Support content types whose fields differ substantially.
- Avoid hard-coded token documentation in editorial guidance.
- Improve token selection in Rules or ECA configuration.
- Give a bundle's token type the content type's own description as help text.
- Keep the generic node token type available alongside the new ones.
- Prevent tokens that silently resolve to nothing from being offered.
- Make token pickers usable on sites with dozens of fields.
- Improve accuracy of token-based file naming.
- Support reference fields correctly through the entity mapper.
- Roll out with no configuration or content changes.
