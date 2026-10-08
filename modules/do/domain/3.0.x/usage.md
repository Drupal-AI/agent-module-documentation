Domain (Domain Access) lets one Drupal installation answer to many hostnames, each represented by a `domain` config entity, and negotiates the "active domain" for every request by matching the incoming hostname.

---

The core `domain` module defines a `domain` config entity (config prefix `domain.record.*`) holding an `id` (machine name), a numeric `domain_id`, a `hostname`, a human `name`, a `scheme` (http/https/variable), `status`, `weight`, an `is_default` flag, and an optional `path_prefix`. On every request the `DomainNegotiator` service resolves which domain is active by comparing the HTTP host to registered hostnames (exact match, then www-prefix and alias handling), falling back to the default domain. The first domain you create is automatically marked default. Domains are managed at `/admin/config/domain` (route `domain.admin`) or with the `drush domain:*` commands, and global behavior (www prefix handling, path-prefix support, allowed login paths for inactive domains, per-domain CSS body classes, language negotiation) lives in the `domain.settings` config object at `/admin/config/domain/settings`. Domain itself only creates and negotiates the records; its submodules add the features you usually want on top — `domain_access` for per-domain content/user access, `domain_source` for canonical outbound URLs, `domain_config`/`domain_config_ui` for per-domain configuration overrides, `domain_alias` for extra hostname patterns, and `domain_content` for per-domain content administration. It also ships blocks (domain nav, switcher, server, token), a `domain` condition plugin, Views access/filter/argument plugins, entity-reference selection handlers, tokens, and a cache context so output can vary per active domain.

---

- Run several branded sites (example.com, example.org, example.net) from a single Drupal codebase and database.
- Register a new hostname as a `domain` record so the site responds to it.
- Set which domain is the default (canonical) domain for the installation.
- Negotiate the active domain per request by matching the incoming HTTP host.
- Mark a domain inactive (offline) while keeping login/password paths reachable.
- Force a domain to always use https (or http, or inherit) via its `scheme`.
- Order domains with a weight so the admin list and switchers show them consistently.
- Give a domain a URL path prefix so it can be served under `/subsite` style paths.
- List, add, delete, enable, disable, or rename domains from the command line with `drush domain:*`.
- Bulk-generate test domains for a dev environment with `drush domain:generate`.
- Rename or bulk-replace a hostname across the site (e.g. staging.example.com → example.com) with `drush domain:replace`.
- Add a "switch domain" block so editors can jump between affiliate sites.
- Show a navigation block linking to each registered domain.
- Vary rendered/cached output per active domain using the `domain` cache context.
- Show or hide a block only on specific domains with the `domain` condition plugin.
- Restrict a View to certain domains, or expose a domain filter/contextual argument in Views.
- Reference a domain from another entity using the domain entity-reference selection handlers.
- Print the current or default domain's hostname/URL in text via Domain tokens.
- Grant editors access to administer only their assigned domains (assigned-domain permissions).
- Debug domain negotiation with the "view domain information" permission and `drush domain:test`.
- React to domain load/negotiation in custom code via `hook_domain_load` and `hook_domain_request_alter`.
- Add per-domain operation links to the admin list with `hook_domain_operations`.
- Build an affiliate publishing model where content is shared across, or scoped to, specific domains (with `domain_access`).
- Give each domain its own canonical outbound URLs for shared content (with `domain_source`).
- Override configuration such as site name, slogan, or theme per domain (with `domain_config` / `domain_config_ui`).
- Point multiple hostnames (www and non-www, country TLDs, environment URLs) at one domain record (with `domain_alias`).
