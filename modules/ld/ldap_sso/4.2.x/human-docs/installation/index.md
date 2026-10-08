# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The [LDAP](https://www.drupal.org/project/ldap) suite at **`^4.4`**
  (`drupal/ldap`), with two of its modules enabled and configured:
  - **`ldap_servers`** — your directory server connection.
  - **`ldap_authentication`** — the LDAP login/validation logic that LDAP SSO
    hands identities to.
- A **web server that performs the upstream authentication** (Kerberos or NTLM)
  and passes the identity to PHP in a server variable. This is the part that
  makes SSO possible, and configuring it (in Apache, for example) is a
  prerequisite outside of Drupal — see the module's README for sample Apache
  NTLM/LDAP configuration.

This module requires the LDAP suite to be **fully configured** for proper
operation, not merely installed.

## Install with Composer

From the project root:

```bash
composer require drupal/ldap_sso -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in `drupal/ldap`
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ldap_sso -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ldap_sso -y
```

This also enables the `ldap_servers` and `ldap_authentication` dependencies if
they are not already on.

## Verify it worked

Confirm the module is enabled and that your LDAP server connection tests
successfully from the LDAP suite's admin pages. Then, from a browser inside your
managed domain (one the web server can authenticate), visit `/user/login/sso` —
you should be logged in without being shown a login form. Keep a standard
`/user/login` path available so directory‑external and administrative accounts
can still sign in.
