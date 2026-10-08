<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring and serving microsites

Everything lives in `domain_microsite.module`, `domain_microsite.services.yml`,
`domain_microsite.install` and three classes under `src/`. There is **no settings page** and
**no config object** — a microsite is a `domain` config entity with extra third-party settings.

## Install & enable

```bash
composer require drupal/domain_microsite:2.x-dev   # no stable tag exists
drush en domain_microsite -y
```

Requires the base **`domain`** module. At least one *regular* (non-microsite) domain record must
exist first to serve as the parent. There is no install-time config; `hook_install` is not
implemented. Only `domain_microsite_update_8105()` exists — it migrates an old
`canonical_hostname` third-party setting to `parent_domain_id` on existing domains.

Caching caveat (from README/data): base Domain caches routes in a way that conflicts with
sub-path microsites; the project references domain issue #3359253 (patch #2) to make route caches
work.

## Creating a microsite (domain edit form)

`domain_microsite_form_domain_edit_form_alter()` adds a **"Domain microsite by path"** fieldset to
the standard domain add/edit form (`admin/config/domain/add`) with three inputs:

| Field | Stored as third-party setting | Notes |
|---|---|---|
| **Make domain microsite** (checkbox) | `is_domain_microsite` | Turns the record into a microsite. |
| **Parent domain** (select) | `parent_domain_id` | The parent whose hostname is the canonical host. Parents that are themselves microsites are excluded from the options. |
| **Base path** (textfield) | `base_path` | e.g. `/promo`. Must start with a slash, no trailing slash, not `/`. |

While the box is checked, the form JS `#states` disable **Set as default domain** and **Test
server response**, and the **Hostname** field is made read-only. `hostname` and `machine_name`
are ignored on input — see auto-generation below.

### Validation (`domain_microsite_domain_edit_form_validate`)

Prepended to `$form['#validate']`. For a new microsite it calls `$domain->createDomainId()` and
overwrites the id/hostname with generated values from `DomainMicrositeConstants`:
`DOMAIN_MICROSITE_ID_PATTERN = 'dm%d'`, `DOMAIN_MICROSITE_HOSTNAME_PATTERN = 'domain-microsite.%d'`
(clearing the earlier machine-name error so the generated id is accepted). It then writes the three
third-party settings and enforces:

- parent domain must exist;
- this domain may not be a microsite if another microsite names it as parent;
- no duplicate (same `parent_domain_id` + `base_path`);
- base path must start with `/`, not end with `/`, and not be `/`;
- a microsite cannot be the default domain.

Unchecking the box removes all `domain_microsite` third-party settings from the record.

## Request negotiation (`hook_domain_request_alter`)

`domain_microsite_domain_request_alter(DomainInterface &$request_domain)` runs on every request
(result memoised in a static):

1. Reads the trimmed request path (below `$base_path`); returns if empty (home page of the parent).
2. Builds a map of `base_path => domain id` for microsites whose parent's hostname equals the
   request host.
3. Longest-prefix match: tries the full path, then drops the last segment repeatedly.
4. On a match, if the microsite is **inactive** and the user is **not** an admin
   (`administer domains` or `access inactive domains` — mirroring
   `Drupal\domain\Access\DomainAccessCheck`), it stops (falls back to the parent domain).
5. Otherwise it copies the parent's `alias` setting, sets the microsite as `$request_domain`, and
   calls `setMatchType()`.

`hook_ENTITY_TYPE_load` (`domain_microsite_domain_load`) rewrites each microsite domain's URL/path
in memory to `parent-hostname + base_path` so `getUrl()`/`getPath()` produce working URLs.

## Path processing (`DomainMicrositePathProcessor`)

Registered in `domain_microsite.services.yml` as both an **inbound** processor (priority 350, before
core language/front/alias processors) and **outbound** processor (priority 50, after them);
constructor args `@entity_type.manager`, `@domain.negotiator`, `@path_alias.manager`,
`@module_handler`.

- `processInbound()` — if the active domain has a base path and the request path starts with it,
  strips the base path (only on a whole-segment boundary) so internal routing sees the real path.
- `processOutbound()` — prepends the active microsite's base path (via `$options['prefix']`) to
  generated URLs. For a `ContentEntityInterface` it also redirects links to the correct site:
  if the entity is not assigned to the active domain (reads `field_domain_access` /
  `field_domain_all_affiliates`) it uses the first assigned domain; if `field_domain_source` is set
  it uses that source domain — setting `$options['base_url']` via `domain_microsite_scheme_and_host()`
  and the target microsite's prefix. When **domain_path** is enabled it resolves the per-domain
  alias for the target domain. Always adds the `url.site` cache context.

These outbound rewrites use only the entity's own domain-assignment fields and the domains' own
stored paths — no request-supplied URL is fetched server-side.

## Cache context override (`DomainMicrositeCacheContext`)

`domain_microsite.services.yml` redefines the core `cache_context.url.site` service with this class
(extends core `SiteCacheContext`). `getContext()` returns the **active domain id** when a domain is
negotiated (else falls back to core). This keys render/page caches per microsite so cached markup —
including base-path-prefixed URLs — does not leak between the parent and its microsites.

## Admin overview & contextual links

- `domain_microsite_form_domain_admin_overview_form_alter()` relabels the *Hostname* column to
  *Site URL*, shows each record's `getPath()` as the link, and hides the "make default" operation
  for microsites (admin-only page, gated by Domain's `administer domains`).
- `domain_microsite_preprocess()` appends `&domain_microsite_base_path=<path>` to the contextual
  links placeholder id so the JS cache key (and generated admin links) stay correct under a
  microsite. `hook_help` renders `README.md` on `help.page.domain_microsite`.

## What it does NOT do

No own routes, permissions, Drush commands, plugin types, blocks, entities or config objects.
Content scoping, per-domain theming/front-page/menus and source URLs come from the wider Domain
ecosystem (Domain Access, Domain Source, Domain Config, domain_path), not from this module. README
notes it does not validate microsite base paths against existing path aliases — the base path takes
precedence.
