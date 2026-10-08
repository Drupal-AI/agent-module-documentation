<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds a Toolbar tab that shows the revision/version status of the entity you are currently viewing, with links to its canonical, latest and history versions.

---

Admin Toolbar Entity Version puts a right-aligned tab in the core Toolbar whenever you are on an entity's canonical, latest-version or a revision route. The tab's label is the current version's status (its content-moderation state when the entity is moderated, otherwise Published/Unpublished), coloured to flag an unpublished current version. Opening it reveals a drawer that lists the entity's **Canonical** revision, its **Latest revision** (when different from canonical) and the **Old revision** you may be viewing — each with a status, a "created … ago" timestamp, and a "View" link — plus a "View version history" link when you have access to it. It works for any revisionable entity type (nodes, and others that expose canonical/latest-version/revision routes) and integrates with Content Moderation when present to show workflow state labels. It also hides the redundant core "Latest version" local task tab on front-end (non-admin) renders. The tab is only built for users who can access the Toolbar, and the version-history link is access-checked before display.

---

- See at a glance whether the node you're viewing is the published (canonical) version or a newer draft.
- Read the current revision's moderation state (e.g. Draft, Published, Archived) right from the Toolbar on moderated content.
- Jump between the canonical version and the latest revision of an entity via the drawer's "View" links.
- Open the full revision history of the current entity with the "View version history" link (shown only when accessible).
- Spot unpublished current versions quickly thanks to the highlighted (yellow) status label.
- Check when each version was created with the relative "… ago" timestamps in the drawer.
- Give editors and reviewers a consistent version indicator across all revisionable entity types, not just nodes.
- Confirm you are editing/reviewing the right revision before making changes in a moderated workflow.
- Help developers debug revision/moderation behavior by surfacing which revision a route resolved to.
- Avoid confusion on latest-version (pending revision) routes by clearly labelling "Latest revision" vs "Canonical".
- Work on old-revision view pages, labelling the viewed revision as "Old revision".
- Reduce clutter by removing the duplicate core "Latest version" tab on front-end renders where the Toolbar tab already conveys it.
- Support Content Moderation workflows out of the box, falling back to Published/Unpublished when moderation is not used.
- Provide quick navigation for content teams working with pending revisions and forward revisions.
- Complement Admin Toolbar for a richer editorial toolbar experience (works well alongside it, though it only requires core Toolbar).
- Surface version context without opening the revisions tab, speeding up review of large content sets.
- Style the drawer via the module's own CSS library so it fits the Toolbar visually.
