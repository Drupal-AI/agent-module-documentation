<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Scoping redirects to a domain (field, forms, install, admin view)

## Install & enable

```bash
composer require drupal/domain_redirect
drush en domain_redirect -y
```

Requires **Domain** (`domain` ^3) and **Redirect** (`redirect` ^1); both are
enabled if not already on. No configuration is needed and there is **no settings
route** (`configure` is null). `require-dev` lists `drupal/domain_path` ^3 — needed
only for the optional alias-inheritance integration (see
[api/matching.md](../api/matching.md)).

## The `domain_id` field

`DomainRedirectHooks::entityBaseFieldInfo()` (`hook_entity_base_field_info`, in
`src/Hook/DomainRedirectHooks.php`) adds one base field to the **`redirect`** entity:

- id `domain_id`, type `entity_reference`, `target_type: domain`.
- Label **Domain**, described "The domain this redirect applies to. Leave empty for
  all domains." — i.e. **NULL/empty = global**, applies to every domain.
- Form widget `options_select`, weight 3, display-configurable on form and view.

Because it is a base field there is no `config/install` or `config/schema` shipped;
the field lives in the redirect entity's field storage.

## Redirect add/edit form

`DomainRedirectHooks::formRedirectFormAlter()` alters both
`redirect_redirect_form` and `redirect_redirect_edit_form`. It prepends an
`_none => "- All domains -"` option to the `domain_id` widget so leaving it unset
means global, and unsets a stray `_none_original` option. This is the only UI the
module adds — everything is inside the Redirect module's own form at
**Configuration → Search and metadata → URL redirects** (`/admin/config/search/redirect`).

## Admin view: Domain column + filter

- `DomainRedirectHooks::viewsDataAlter()` (`hook_views_data_alter`) sets the filter
  plugin for `redirect.domain_id` to `domain_filter` (a select list of domains).
- `domain_redirect.install` edits config **`views.view.redirect`** at install
  (`_domain_redirect_alter_view(TRUE)`): inserts a `domain_id` field (plugin
  `standard`, label "Domain", empty "All") before the `created` column, registers it
  in the table style columns/info, and adds an **exposed** `domain_id` filter
  (plugin `domain_filter`, operator `in`). The field intentionally omits
  `entity_type`/`entity_field` to avoid a computed config dependency that would delete
  the view on uninstall.
- `hook_module_preuninstall` (in `domain_redirect.module`) calls
  `_domain_redirect_alter_view(FALSE)` **before** dependency resolution to strip the
  column and filter, so uninstalling does not remove the redirect view.

## Database schema changes (`domain_redirect.install`)

- `hook_install` drops the `redirect` table's unique key on `hash` (so the same
  hash can repeat across domains) and adds a composite index `hash_domain` on
  `(hash, domain_id)` for lookup performance. Uniqueness is then enforced only at
  the application level by the entity constraint (see [api/matching.md](../api/matching.md)).
- `hook_uninstall` drops `hash_domain` and restores the original unique key on `hash`.

## Operating it

1. Add/edit a redirect at `/admin/config/search/redirect`.
2. Set **Domain** to a specific domain (redirect applies only there) or leave it
   **- All domains -** (global).
3. The same source path may now be entered once per domain; domain-specific entries
   override a global one on their domain.
4. Use the exposed **Domain** filter on the listing to narrow by domain.
