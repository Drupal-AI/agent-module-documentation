# Installation

## Requirements

- **Drupal 9, 10 or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **SAML Authentication** module (`samlauth`) — this is a hard dependency and
  must be installed and configured against your identity provider. SAML Rules
  reads the SAML response that `samlauth` handles; it does not talk to the IdP on
  its own.

There are no additional PHP or third‑party library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/saml_rules -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in `samlauth` and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/saml_rules -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en saml_rules -y
```

Drupal will enable `samlauth` at the same time if it is not already on. Enabling
the module adds the admin screens and the login hook, but nothing changes for
your users until you create at least one rule.

## Verify it worked

Log in as an administrator and go to **Configuration → People → SAML Rules**
(`/admin/config/people/saml-rules`). You should see the rule matrices and the
settings form. From here, continue to [Configuration](../configuration/index.md)
to build your first rule.
