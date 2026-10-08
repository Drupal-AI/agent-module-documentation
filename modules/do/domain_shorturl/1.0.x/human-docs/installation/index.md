# Installation

## Requirements

- **Drupal 10.3+ or 11.2+** (`core_version_requirement: ^10.3 || ^11.2`).
- The **Short URL** module (`shorturl`), version **^2** — the module it makes
  domain-aware.
- The **Domain** module (`domain`), version **^3**.
- **Domain Redirect** (`domain_redirect`), version **^2** — so redirects are scoped
  to the correct domain automatically.

**Optional but recommended:** the **Domain Access** submodule (`^3`). When present,
it filters the domain selector on the short-URL node form to the domains a user is
assigned.

There are no third-party PHP or Composer library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/domain_shorturl -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed, pulling in Short URL, Domain, and Domain Redirect.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/domain_shorturl -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en domain_shorturl -y
```

Enabling the module runs an install hook that automatically:

- adds a `domain_id` column to the `shorturl_visits` table (for per-domain visit
  tracking), and
- adds the domain field to the short-URL add/edit form and its view displays.

Uninstalling the module cleanly reverses both changes.

## Verify it worked

Add a short URL (through the Short URL module's normal flow). You should see a new
**Domain** selector on the form, and the settings form should be available at
**Configuration → Domain → Short URL** (`/admin/config/domain/shorturl`). See
[Configuration](../configuration/index.md) next.
