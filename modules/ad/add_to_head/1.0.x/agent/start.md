<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Add To Head — agent index

Lets site builders define named **profiles** — blocks of raw HTML/CSS/JS — that get injected
into pages, scoped by **path** and **role**. Profiles are NOT config entities: they all live
inside one config object, `add_to_head.settings`, as an associative array keyed by each
profile's own machine `name`. Gated by a single permission, `administer add to head`
(marked `restrict access: TRUE` because it allows arbitrary markup injection).

- **Profile structure, scopes (`head`/`scripts`/`styles`), which hook renders each, path/role
  visibility rules, the admin route + permission** →
  [configure/profiles.md](configure/profiles.md)
- **Read/write profiles programmatically (`add_to_head_get_settings()`,
  `add_to_head_set_settings()`) and the `hook_add_to_head_profiles_alter()` alter hook** →
  [api/helpers.md](api/helpers.md)

Key facts:
- Admin UI: `/admin/config/development/add-to-head` (route `add_to_head.admin`), permission
  `administer add to head`.
- Config: `add_to_head.settings` → key `add_to_head_profiles`, an array keyed by profile name.
- Scopes: `head` → `hook_page_attachments_alter()` → `#attached['html_head']` (early in
  `<head>`, before CSS/JS). `scripts` → `hook_page_bottom()` (near end of page output).
  `styles` is offered in the form/schema but `hook_css_alter()` is an intentional no-op — CSS
  profiles do not currently render anywhere.
- No config entities, no plugins, no Drush commands.
