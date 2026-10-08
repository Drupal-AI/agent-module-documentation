<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
A text-format filter that rewrites Linkit-authored links pointing at unpublished nodes so they include the visitor's `access_unpublished` token, letting a draft-preview session follow links between unpublished pages.
---
When a page is viewed with a valid `auHash` query parameter, the filter (`AccessUnpublishedLinkedNodes`, weight 199) and a `hook_preprocess_html()` implementation validate the hash against the active token managed by the `access_unpublished` module (`AccessUnpublishedHelper::validateAuHash`). Only then does the module walk the rendered body with DOMDocument, find `<a data-entity-uuid>` links to unpublished nodes, and swap their href for that node's token URL (`getHashTag`), so the draft-to-draft navigation keeps working. It can also render the latest (possibly unpublished) revision of embedded `block_content` blocks when the optional `embed_block` module is present.

Access is intentionally scoped: `roleChecks()` only proceeds for users whose roles are all within `anonymous`, `authenticated`, `viewer` (so editors' normal experience is untouched), and the actual authorization always defers to the `access_unpublished` token — the module never grants access on its own, it only propagates a valid token to linked drafts. Token generation via `getHashTag()` additionally requires the per-bundle `access_unpublished node <type>` permission. Configure which content types are processed at `/admin/config/content/access-unpublished-linked-nodes` (`administer site configuration`). Note the module reads `$_GET`/DOM and builds tokened URLs; it relies on `access_unpublished` tokens being unguessable.
---
- Let a draft-preview visitor click through links between unpublished pages.
- Rewrite Linkit links to unpublished nodes to include the access token.
- Preserve `auHash`-based preview across a chain of linked drafts.
- Restrict processing to selected content types via the settings form.
- Validate the `auHash` parameter against the active access_unpublished token.
- Limit preview link rewriting to anonymous/authenticated/viewer roles.
- Preview latest revisions of embedded custom blocks during draft review.
- Share a single preview link that keeps working across internal draft links.
- Configure processed node types at the settings page.
- Integrate with the access_unpublished token manager for authorization.
- Require the per-bundle `access_unpublished node <type>` permission to mint tokens.
- Keep editors' normal editing experience unaffected by the rewriting.
- Add a CSS marker class (`access-unpublished-pass`) on qualifying preview pages.
- Work with content-moderation workflows to detect non-published states.
- Fall back gracefully (no rewrite) when no valid token is present.
- Support landing-page/page defaults when no types are configured.
- Give reviewers a seamless multi-page draft walkthrough before publishing.
- Avoid creating path aliases or exposing drafts to unauthorized users.
- Attach the module's library only when a preview is authorized.
- Handle script tags safely by extracting them before DOM parsing.