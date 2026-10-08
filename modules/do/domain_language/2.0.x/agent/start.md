<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Domain Language (domain_language) — agent index

Per-domain default language + allowed-language subset for Domain Access sites. Requires
`domain`, `domain_config` and core `language`. No `configure` route in info.yml — the form is
reached as a **row operation on the domain list** (`/admin/config/domain`).

- **The form, the two config objects it writes, and how to set them from Drush** →
  [configure/per-domain-language.md](configure/per-domain-language.md)
- **The override mechanics: config overrider, swapped `language.default`, switcher alter** →
  [api/overrides.md](api/overrides.md)
- **The single permission and what bypassing means** →
  [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Route `domain_language.admin` — `/admin/config/domain/language/{domain}/edit`, permission
  **`administer domains`** (Domain Access's own permission, not one of this module's).
  Added to the domain list via `hook_domain_operations()` with weight 70.
- Two config objects per domain (no schema shipped for either):
  - `domain.config.{domain}.system.site` → `default_langcode`
  - `domain.language.{domain}.language.negotiation` → `languages` (map langcode → langcode)
- Choosing *Site's default language* **unsets** `default_langcode` and deletes the config object
  if it becomes empty; clearing every checkbox deletes the `domain.language.*` object entirely
  (meaning "all languages allowed").
- The submit handler always adds the selected default into `languages`, and strips
  `url.prefixes` / `url.domains` from `domain.config.{domain}.language.negotiation` to prevent a
  competing override. It then rebuilds routes (`router.builder`).
- **Fatal as shipped (2.0.0-alpha2) — verified on Drupal 11.4.4.** `domain_language.services.yml`
  registers the overrider with `arguments: ['@config.storage']`, but
  `DomainLanguageOverrider::__construct()` expects
  `(AccountProxyInterface $current_user, DomainNegotiatorInterface, ConfigFactoryInterface,
  OverriderInterface)`. A `config.factory.override` service is instantiated during container
  build, so enabling the module kills the site:

  ```
  PHP Fatal error: Uncaught TypeError:
  Drupal\domain_language\DomainLanguageOverrider::__construct(): Argument #1 ($current_user)
  must be of type Drupal\Core\Session\AccountProxyInterface,
  Drupal\config_readonly\Config\ConfigReadonlyStorage given
  ```

  (The concrete class in the message is whatever decorates `config.storage` on your site.) The
  class defines a `create()`, but a plain `class`/`arguments` definition never calls it. Recovery
  is the same as for any bootstrap-fatal module: strip it from `core.extension` in the `config`
  table and truncate the cache tables. Everything below is documented from source; a working
  deployment needs the services.yml fixed to `['@current_user', '@domain.negotiator',
  '@config.factory', '@domain_config.overrider']` (or the service switched to a factory).
- Restriction is **presentation/negotiation level, not access control**.
