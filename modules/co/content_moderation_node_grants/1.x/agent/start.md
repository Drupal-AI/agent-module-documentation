<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Content Moderation Node Grants (content_moderation_node_grants) — agent index

Adds **node access grants for content-moderated content** — restricts view/edit of unpublished
(draft/pending) revisions by permission. Version **1.2.0**. Addresses core issue #3161658.

**Verified correct (positive):** an unpublished node returned **403 to anonymous**; its node_access
records show it's viewable only via `view_any_unpublished_content` / `view_own_unpublished_content`
realms (permission-gated) — no grant in the generic view realm, so **drafts are not leaked**.

Note node access is **additive** across modules — the site-wide outcome is the union of all
node-access modules' grants. Run `node_access_rebuild` after enabling.