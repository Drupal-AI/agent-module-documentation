Domain Path lets a content entity have a **different URL alias for each domain** in a multi-domain (Domain module) Drupal site. Where core allows one alias per entity per language, Domain Path adds a per-domain alias, stored as a normal `path_alias` entity tagged with a `domain_id`.

---

Domain Path requires the Domain module. Once enabled, entity edit forms for the configured entity types (Node only by default) show a *Domain-specific aliases* section with one alias field per domain (placed in the advanced sidebar by default). Under the hood the module adds a `domain_id` base field to core's `path_alias` entity, swaps the `path_alias` class for its own `DomainPathAlias`, and adds a computed `domain_path` field to enabled entity types. When you save an alias for a domain, a `path_alias` entity is created/updated with that `domain_id`; erasing it deletes the alias. At outbound URL time the module decorates core's `path_alias.manager` and `path_alias.repository` and registers a path processor (priority 305) that, given a target domain (typically set by Domain Source), resolves the alias whose `domain_id` matches, otherwise falls back to the default alias. Settings live in the `domain_path.settings` config object — `entity_types` (which types get domain aliases), `alias_title` (how domains are labelled in the widget: name/hostname/url), `hide_path_alias_ui` (hide core's URL-alias field), `use_advanced_group` (put the widget in the advanced tab), and `language_method` (which language is used to resolve aliases). The settings form is at `/admin/config/domain/domain_path` (permission `administer domain paths`). With Domain Access installed, users only see and can only set aliases for domains they are assigned to, and aliases are only written for domains the entity belongs to. The optional **Domain Path Pathauto** submodule adds automatic per-domain alias generation. Uniqueness of aliases is enforced per domain.

---

- Give a node a different URL on each domain (e.g. `/products/widget` on one, `/widget` on another).
- Run an affiliate/brand multisite where the same content has brand-specific URLs.
- Localize URLs per domain and per language (per-domain, per-language aliases).
- Hide the core URL-alias field to avoid confusion with the per-domain aliases.
- Label the domain alias fields by domain name, hostname, or full URL.
- Place the domain alias widget in the node form's advanced sidebar (or inline).
- Restrict which entity types support domain aliases (default: Node only).
- Add domain aliases to users, taxonomy terms, or other entity types via settings.
- With Domain Access, show each editor only the domains they manage.
- Only write aliases for the domains an entity is actually published to (with Domain Access).
- Let admins with 'administer url aliases' set aliases for every domain.
- Resolve cross-domain links to the correct per-domain alias (with Domain Source).
- Keep a default alias as fallback when a domain has no specific alias.
- Enforce per-domain alias uniqueness (two domains can reuse the same alias string).
- Delete a domain's aliases automatically when that domain is deleted.
- Choose whether alias resolution follows content, interface, or URL language.
- Migrate multi-domain URL structures by importing domain-tagged path aliases.
- Combine with Pathauto (via the submodule) for automatic per-domain aliases.
- Provide SEO-friendly, domain-appropriate URLs on each storefront.
- Override a pathauto-generated alias with a hand-crafted one on a specific domain.
- Store domain aliases as standard path_alias entities (queryable, revisionable).
- Manage domain aliases through the node form without custom code.
- Support workspaces/translations where each translation has its own domain aliases.
