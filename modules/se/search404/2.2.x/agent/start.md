# search404 — agent start

Turns 404 (Page not found) responses into a keyword search built from the requested URL, showing
search results — or jumping straight to a match — instead of a plain error. On install it sets
`system.site` `page.404` to `/search404`, whose controller parses keywords from the path and runs
the site's default **core Search** page (also works with Search API / a View via a custom search
path). No hard module dependencies; no permissions of its own (uses core `administer search` /
`access content`). Config UI: **Admin → Config → Search and metadata → Search 404 settings**
(`/admin/config/search/search404`); settings route `search404.settings`.

- Configure the search backend, keyword parsing, jump-to-first, abort rules & custom 404 text → [configure/settings.md](configure/settings.md)
- Permissions & access → [permissions/permissions.md](permissions/permissions.md)
