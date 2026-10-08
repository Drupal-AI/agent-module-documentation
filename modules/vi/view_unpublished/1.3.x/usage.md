View Unpublished lets you grant specific user roles permission to view unpublished nodes — either all content types or just selected ones — without giving them full content-administration rights.

---

Drupal core only lets a user see unpublished nodes if they can administer the node or own it; there is no built-in way to say "editors may read (but not edit) any unpublished page." View Unpublished fills that gap by implementing the node access grant system (`hook_node_grants()` / `hook_node_access_records()`) so that unpublished nodes become viewable to roles you choose. It exposes a global `view any unpublished content` permission plus one dynamically generated permission per content type (e.g. `view any unpublished article content`), so access can be as broad or as granular as needed. Access is purely read-only — it does not grant edit or delete — and it requires no changes to your URL structure. It also ships a Views filter (`NodeStatus`) that overrides core's "Published status or admin user" filter so listings such as the Content overview respect these custom permissions. Because it uses the grants system, after enabling or changing permissions you may need to rebuild node access permissions at Reports → Status. It pairs well with content moderation and preview workflows where reviewers must see drafts they cannot edit.

---

- Let a "reviewer" role read every unpublished node on the site.
- Allow editors to preview unpublished pages they do not own.
- Grant view access to unpublished content of only one content type (e.g. Article).
- Give a client role read-only access to draft content before launch.
- Let stakeholders review unpublished pages without edit permissions.
- Show unpublished nodes to a role in the core Content overview "not published" filter.
- Support a moderation workflow where reviewers see drafts but cannot change them.
- Provide QA testers visibility into unpublished content.
- Let translators view unpublished source nodes awaiting translation.
- Expose unpublished nodes to a specific role via a custom View using the correct filter.
- Grant per-content-type draft visibility to different departments.
- Allow a marketing role to preview unpublished campaign landing pages.
- Give support staff read access to unpublished knowledge-base articles.
- Let authenticated members view unpublished announcements before go-live.
- Keep draft URLs stable while controlling who can view them.
- Combine with Override Node Options to let roles publish without full admin.
- Audit draft content across the site with a read-only role.
- Preview embargoed content for legal/compliance review.
- Provide decoupled front-ends' preview accounts read access to unpublished nodes.
- Restrict draft visibility so anonymous users still get access-denied.
- Grant a role visibility of unpublished content of several selected types only.
- Rebuild node access grants after changing which roles may view drafts.
- Let editors of one section see drafts only in their content type.
