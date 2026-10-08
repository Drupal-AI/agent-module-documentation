# admin_toolbar_links_access_filter — agent start

**Deprecated** (Drupal 10.3+ handles this in core — see info.yml `lifecycle_link`). Trivial
module: a single `hook_preprocess_menu()` in
`admin_toolbar_links_access_filter.module` that strips admin menu links the current user
lacks access to. Requires `admin_toolbar`. No config, no permissions, no services — nothing
to configure. Do not install on new Drupal 10.3+ sites.
