# Advanced Datalayer example — agent index

Ships ready-made **tag & group plugins** for `advanced_datalayer` (the base module defines
none). Enable it to get a working GTM dataLayer you can assign values to. No routes,
permissions, or services of its own.

- **The tags & groups it provides, and using them as templates** →
  [plugins/example-tags.md](plugins/example-tags.md)

Key facts:
- Groups: `site_Information`, `page_Information` (plus core `root`).
- Tags: `event` (root), `site_Name` / `site_Category` / `ga_client_id` (site_Information),
  `page_Name` / `page_Category` / `response_Code` (page_Information).
- Assign values to these tag ids via the base module's `advanced_datalayer_defaults` config —
  see `modules/advanced_datalayer/2.1.x/agent/configure/defaults.md`.
- To author your own, copy a tag/group class — see
  `modules/advanced_datalayer/2.1.x/agent/plugins/tags-and-groups.md`.
- Implements `hook_page_attachments()` to attach `js/example_advanced_datalayer.js` for
  client-side values (device type, GA client id) when global tags are present.
