<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LocalGov Microsites Group (localgov_microsites_group) — agent index

**Multi-tenant "microsites" platform for LocalGov Drupal — each microsite is a domain-bound Group with its own theme, enabled modules, content types and members.**

- **Version:** 4.6.x (4.6.1)
- **Core:** ^9.3 || ^10 || ^11
- **Key routes:** `/admin/microsites/add/{group_type}` (`_entity_create_access group:{group_type}`), `/admin/microsite` (custom access → current-group context), `/group/{group}/domain-settings` (custom access).
- **Plugin type:** `DomainGroupSettings` (Theme, SiteSettings, ContentTypeSettings, MicrositeDomain).
- **Access policies:** `ControlSiteAccessPolicy`, `MicrositeContentTypesAccessPolicy`.
- **Permissions:** `access microsites overview`, `bypass domain group permissions`; group permissions `administer group domain settings` (restricted), `set localgov microsite theme override`, `manage microsite enabled module permissions`.
- **Submodules:** permissions + content packs (blogs, news, events, guides, directories, publications, step_by_step, group_webform, group_term_ui).
- **Security:** All custom routes are gated (`_entity_create_access` / `_custom_access`); the domain-settings form access = `bypass domain group permissions` OR a settings-plugin's own group/account access check; microsite-admin redirect only allows when a group context resolves. No `_access:TRUE` or `access content`-gated mutating routes, no disabled TLS, no raw SQL or unsafe unserialize observed. See [configure/microsites.md](configure/microsites.md).