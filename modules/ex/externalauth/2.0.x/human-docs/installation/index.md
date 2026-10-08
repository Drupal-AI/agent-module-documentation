# Installation

## Requirements

External Authentication is lightweight and has no module dependencies of its own:

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- No other contrib modules and no third‑party PHP libraries are required.

In practice you seldom install this module by hand — an SSO, LDAP, OAuth, or
SAML module that depends on it will bring it in automatically when you install
that module with Composer.

## Install with Composer

From the project root:

```bash
composer require drupal/externalauth -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/externalauth -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en externalauth -y
```

That's all it takes. There is no required configuration — the two `Authmap` and
`ExternalAuth` services become available to any module that depends on them, and
the stored‑mappings listing appears at **People → Authmap**
(`/admin/people/authmap`).

There are **no submodules**.
