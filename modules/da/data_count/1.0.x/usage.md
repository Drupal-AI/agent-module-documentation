Data Count adds one admin report at Reports > Data Count that tallies published/unpublished nodes per content type and active/inactive users per custom role.

---

Data Count is a small, configuration-free statistics module for administrators. Enabling it exposes a single page at `/admin/reports/data-count` (menu item under Reports, permission `administer site configuration`). The page has two tab-like panels toggled with jQuery: a "Node Count Details" table listing every content type with its published, unpublished, and total node counts plus grand totals, and a "User Count Details" table listing every custom role with its active, inactive, and total user counts plus site-wide user totals. Counts come from direct `countQuery()` reads of `node_field_data` and `users_field_data` (joined to `user__roles`) via helper functions in `data_count.module`; nothing is stored or cached. Every number is rendered as a link to the corresponding filtered `admin/content` or `admin/people` listing, so an administrator can click any figure to drill into the underlying nodes or accounts. There are no settings, permissions of its own, Drush commands, config entities, or plugins — it is purely a read-only reporting page.

---

- See at a glance how many nodes exist on the site, split by published vs. unpublished.
- Break down node counts by content type to spot which types dominate your content.
- Identify content types that have a large backlog of unpublished (draft/archived) nodes.
- Get grand totals of all published, unpublished, and total nodes across the whole site.
- Click any node figure to jump to the pre-filtered `admin/content` listing for that type and status.
- Count active vs. inactive (blocked) user accounts per custom role.
- Review how many users hold each role assigned on the site, as an access/permission audit aid.
- Get site-wide totals of active and inactive user accounts.
- Click any user figure to open the pre-filtered `admin/people` listing for that role and status.
- Run quick content audits before a launch or migration without building a View.
- Support editorial reviews by surfacing unpublished-content volume per type.
- Give stakeholders a one-page snapshot of site size (content and accounts).
- Sanity-check a migration by comparing expected vs. reported node/user counts.
- Spot orphaned or unexpected content types by seeing their counts listed.
- Detect roles with large numbers of blocked accounts that may need cleanup.
- Provide a lightweight dashboard link under the standard Reports section for admins.
- Use as a fast reference during support to confirm how much data a site holds.
- Add reporting to small sites where installing Views or a full analytics module is overkill.
- Monitor content growth over time by checking the report periodically.
- Verify that newly created content types appear and begin accumulating nodes.
