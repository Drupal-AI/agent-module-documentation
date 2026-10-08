Bundle Redirect surfaces the Redirect module's per-node URL redirects directly on the node edit form for node bundles you enable.

---

Bundle Redirect is a thin companion to the contrib Redirect module. On its own it stores nothing but a list of enabled node bundle machine names in the `bundle_redirect.settings` config object. When a bundle is enabled, editing an existing node of that bundle shows an extra "URL redirect" vertical tab in the advanced (sidebar) area of the node form. That tab lists all existing redirects whose destination is this node (with Edit/delete operations) and offers an "Add URL redirect to this node" link that opens Redirect's own add form pre-filled with the node path, current language, and a destination back to the node edit form. All redirect creation, editing, and deletion is still performed by the Redirect module and its access rules; Bundle Redirect only decides which bundles get the shortcut and only shows the tab to users holding Redirect's `administer redirects` permission. It works only with nodes today, though the code could be extended to other entity types.

---

- Give editors a place to manage a node's inbound URL redirects without leaving the node edit form.
- Restore the Drupal 7-style "redirect from this page" convenience that core/Redirect dropped in D8+.
- Enable the redirect tab only on the content types (bundles) that actually need managed URLs (e.g. Article, Landing page) and leave others untouched.
- Let content editors add a redirect from an old/renamed URL to the current node in one click.
- Show, per node, every redirect that currently points at that node so editors can audit stale forwards.
- Provide Edit and delete links for each existing node redirect, deep-linking into Redirect's admin UI with a return `destination` to the node edit form.
- Preserve editing context: the add/edit/delete links carry the current interface language and send the user back to the node edit form after the operation.
- Confine the whole feature to users who hold `administer redirects`, so ordinary authors do not see or touch redirects.
- Restrict who can choose the enabled bundles via the dedicated `access bundle redirect setting form` permission.
- Bulk-enable the redirect tab for every existing node bundle at once using the shipped update hook (`bundle_redirect_update_8101`) during an upgrade/deploy.
- Keep redirect data authoritative in the Redirect module (the `redirect` table) — Bundle Redirect adds UI only, so existing redirect reports, imports, and APIs keep working.
- Configure enabled bundles as exportable configuration (`bundle_redirect.settings`) so the choice moves cleanly between environments.
- Handle multilingual sites: the add/edit links pass the current language so redirects are created for the language the editor is working in.
- Onboard a redesign: as you rename or restructure content, editors set up 301s inline while updating each affected node.
- Reduce broken inbound links after content restructuring by making redirect creation part of the normal editing flow.
- Audit a specific node's SEO redirects during content review without opening the global redirect list and filtering.
- Serve as a lightweight base to extend inline redirect management to other entity types (taxonomy terms, etc.) via custom code.
