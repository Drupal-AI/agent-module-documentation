Edit Content Type Tab adds a local task tab on node pages that jumps straight to the edit form of that node's content type, for users who can administer content types.

---

Edit Content Type Tab (ECTT) is a small site-building convenience module. On every node's canonical page it registers an extra local task tab (weight 15) whose label is dynamic — "Edit '<Type Name>' type". Clicking it hits the route `/node/{node}/edit_content_type_tab`, which loads the node, reads its bundle, and issues an HTTP redirect to the core content type management form at `/admin/structure/types/manage/{type}`, carrying a `destination` query so you land back on the node after saving. The tab and route are gated by the core `administer content types` permission, so only site builders and administrators ever see or reach it. The module holds no configuration, defines no permissions of its own, and stores no data; it is purely a navigation shortcut. It does not change or convert the bundle of the node itself — it simply saves the round trip of finding the content type in the admin structure listing, which is handy when a site has many content types and you are iterating on their fields, display, or settings.

---

- Jump from a node you are viewing straight to that node's content type edit form in one click.
- Speed up theming/templating work where you frequently tweak a content type while previewing a real node.
- Iterate on field definitions of a content type without hunting through /admin/structure/types.
- Adjust a content type's Manage fields, Manage form display, or Manage display while looking at example content.
- Quickly reach the content type settings (title label, preview, publishing options) for the node in front of you.
- Help site builders working on sites with many (dozens of) content types find the right type instantly.
- Reduce context switching during content-model refactors by keeping the node and its type one tab apart.
- Return automatically to the node after editing its content type, thanks to the destination parameter.
- Give agency/multi-author teams a faster path for admins to inspect the type behind a piece of content.
- Confirm which content type a given node uses (the tab label shows the human-readable type name).
- Support QA/review workflows where you verify a content type's configuration against live content.
- Streamline building of new content types by editing and re-checking against a seed node repeatedly.
- Provide a discoverable entry point to content type administration for newer site builders.
- Use during migrations to quickly open the destination content type for a migrated node.
- Cut clicks when auditing publishing/moderation settings per content type from example nodes.
- Assist in demos where you show both a node and its underlying content type configuration.
- Keep admins on-task by not requiring them to memorize content type machine names.
- Fit naturally into a "Development" toolset alongside other admin-shortcut modules.
- Works on any node bundle without per-type configuration once the module is enabled.
- Leaves the front-end experience untouched for non-admin users (the tab is permission-gated).
