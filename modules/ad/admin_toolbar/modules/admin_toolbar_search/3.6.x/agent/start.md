# admin_toolbar_search — agent start

Adds a search/filter box to the Admin Toolbar to jump to any admin link by keyword. Depends
on core `toolbar`. Link index built by service `admin_toolbar_search.search_links`
(`SearchLinks.php`), served over AJAX at `/admin/admin-toolbar-search`. Config UI:
`/admin/config/user-interface/admin-toolbar-search` (route `admin_toolbar_search.settings`).

- Settings (inline vs menu item, keyboard shortcut) → [configure/settings.md](configure/settings.md)
- Permission gating the search endpoint → [permissions/permissions.md](permissions/permissions.md)
