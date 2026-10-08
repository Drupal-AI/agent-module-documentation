<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Content Moderation Node Grants adds node access grants for content-moderated content, correctly restricting who can view/edit unpublished (draft/pending) revisions — addressing core issue #3161658.

---

Content Moderation manages draft/review/published states, but core's node access has a long-standing gap (issue #3161658) around who may view or edit pending/unpublished content once node grants are involved. Content Moderation Node Grants fills it with a proper node-access-grants implementation: it emits access records tying view/update/delete of unpublished content to the relevant permissions (view any/own unpublished, edit any/own by type), so moderated content is access-controlled at the node-grant layer — the correct, deep place. Reviewed and verified: with the module enabled, an unpublished node correctly returned 403 to an anonymous request, and its node_access records show it is viewable only via the `view_any_unpublished_content` / `view_own_unpublished_content` realms (permission-gated) — there is no grant in the generic view realm, so drafts are not leaked. This is node grants done right, which matters because getting node grants wrong leaks unpublished content or locks out legitimate access. Remember node access is additive across modules (any module's grant can allow), so if another module also grants view on the same content, that grant applies too — this module governs its own realms correctly; the whole-site outcome is the union of all node-access modules.

---

- Restrict draft access with node grants.
- Control who views unpublished content.
- Fix core moderation node-access gap.
- Gate pending revisions by permission.
- Deny drafts to anonymous.
- Grant view-own-unpublished to authors.
- Grant view-any-unpublished by permission.
- Use node grants for moderation.
- Address core issue 3161658.
- Protect unpublished content.
- Rebuild node access after enabling.
- Verify drafts are not leaked.
- Control edit access to pending content.
- Understand node access is additive.
- Gate by content type.
- Combine with content moderation.
- Enable when needed.
- Keep disabled otherwise.
- Restrict administration.
- Confirm on your site.
- Test before production.
- Review configuration.