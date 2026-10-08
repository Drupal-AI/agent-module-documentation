<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Public Preview

Provides tokenised public preview links for nodes. On a node's 'Preview links' tab an editor generates a per-language link containing a random hash; visiting `\/node/{node}/preview-link/{hash}` renders the node's latest revision even if unpublished. Access is granted by `hook_entity_access` only when the hash matches a stored record for that exact node and language.

---

# Installing & configuring

- Enable the module (depends on `node`).
- Grant `access preview links form` to the roles that may create preview links.
- On a node, open `/node/{node}/preview-links` to generate or remove per-language links.
- Generated links are absolute, language-neutral URLs safe to share externally.

---

- The preview route `\/node/{node}/preview-link/{hash}` has `_access: 'TRUE'` (open) — access is enforced instead by `hook_entity_access`.
- `public_preview_entity_access()` allows `view` only for unpublished entities when a matching hash record exists AND the node id and langcode match.
- The hash is generated with `Random::name(69, TRUE)` — a 69-character alphanumeric token (very large space; non-CSPRNG but impractical to guess/enumerate).
- Hash lookup uses `escapeLike()` with a `LIKE` condition, so wildcard characters are escaped — no wildcard/enumeration bypass.
- The preview response sets `max-age=0` and triggers the page-cache kill switch, so previews are not cached.
- The links form access callback requires the `access preview links form` permission.
- Links are deleted when the node or its translation is deleted (`hook_node_delete`, `hook_entity_translation_delete`).
- Preview shows the LATEST revision (`max(revisionIds)`), i.e. draft content.
- By design this exposes unpublished content to anyone holding the secret link — that is the intended feature.
- Links do NOT expire and have no per-view limit; revoke by removing them on the form.
- Only the specific node+language tied to the hash is exposed — the hash does not grant broader access.
- Preview storage is a custom `public_preview` table modelled on core AliasStorage.
- No anonymous mutation endpoints exist (generation requires the permission).
- Suited to sharing drafts with external reviewers/stakeholders without accounts.
- Operational risk is link leakage (referrer, chat, email) rather than a code flaw; consider adding expiry if that matters.
- The token is unpredictable and scoped, so no access-bypass beyond the intended link-sharing was found.
