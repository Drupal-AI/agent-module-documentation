<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Domain Microsite by Path (domain_microsite) — agent index

Serves a **Domain** config entity as a "microsite" at a **sub-path** of an existing hostname
(e.g. `example.com/promo`) instead of at its own domain name. Built entirely on the contrib
**Domain** module. Package `Domain`. Core `^9 || ^10 || ^11`. License GPL-2.0-or-later.

**Version 2.x — development branch: no stable release is tagged and `info.yml` carries no
`version:` line.** Project is "seeking a new maintainer", "no further development".

- Depends only on **`domain:domain`** (the base Domain module). Works together with, but does not
  require, Domain Access, Domain Source, Domain Config and domain_path.
- Ships **no** routes, permissions, Drush commands, plugin types, or config objects of its own.
  A microsite is a plain Domain entity with three third-party settings.

## What it actually is (from source)

- A microsite = a `domain` config entity with three third-party settings under the
  `domain_microsite` provider: `is_domain_microsite` (bool), `parent_domain_id` (domain id),
  `base_path` (e.g. `/promo`). Set/validated on the normal domain add/edit form — no new UI page.
- **Request negotiation:** `hook_domain_request_alter()` (`domain_microsite.module`) matches the
  incoming path against microsite base paths on the current hostname (longest-prefix first) and
  sets the matched microsite as the active domain.
- **URL rewriting:** `DomainMicrositePathProcessor` (`src/DomainMicrositePathProcessor.php`) — an
  inbound + outbound path processor registered in `domain_microsite.services.yml` — strips the base
  path from inbound paths and prepends it to outbound URLs.
- **Cache correctness:** `DomainMicrositeCacheContext` (`src/DomainMicrositeCacheContext.php`)
  **overrides the core `cache_context.url.site`** service so page caches are keyed by domain id.
- Constants `dm%d` / `domain-microsite.%d` (`src/DomainMicrositeConstants.php`) are the
  auto-generated id/hostname patterns for a new microsite.

## Solution docs

- **Services, hooks, install, and how a microsite is configured & path-scoped per domain** →
  [config/microsites.md](config/microsites.md)

## Key entry points

- Hooks: `hook_domain_request_alter`, `hook_ENTITY_TYPE_load` (domain), two
  `hook_form_FORM_ID_alter` (domain edit + admin overview), `hook_preprocess`, `hook_help`.
- Services: `domain_microsite.path_processor`, `cache_context.url.site` (override),
  `domain_microsite.constants`.
- Helper functions (procedural): `domain_microsite_base_path()`, `domain_microsite_parent_id()`,
  `domain_microsite_scheme_and_host()`.
- Update hook: `domain_microsite_update_8105()` (migrate `canonical_hostname` → `parent_domain_id`).
