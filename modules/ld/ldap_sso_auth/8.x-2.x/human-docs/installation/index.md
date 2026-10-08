# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The [LDAP](https://www.drupal.org/project/ldap) suite, with:
  - **`ldap_servers`** — your directory server connection, and
  - **`ldap_authentication`** — the LDAP login validation this module hands
    identities to.
- A **web server that establishes the SSO identity** (Kerberos, NTLM, or an SSO
  proxy) and sets it in a server variable such as `REMOTE_USER`.
- The maintainers **recommend against enabling core's Internal Page Cache**
  module alongside this one.

## Install with Composer

From the project root:

```bash
composer require drupal/ldap_sso_auth -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in `drupal/ldap`
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ldap_sso_auth -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ldap_sso_auth -y
```

This also enables the `ldap_servers` and `ldap_authentication` dependencies if
they are not already on.

> **Enable on a staging copy first, and test on your exact stack.** How this
> module behaves depends entirely on what your web server puts in the SSO
> variable, which differs between Apache, nginx/php‑fpm and reverse‑proxy setups.
> After enabling, exercise the site from both an **incognito / logged‑out
> browser** and a **domain‑authenticated browser** and confirm each behaves the
> way your site expects before promoting the change to production.

## Verify it worked

Test the SSO path itself: from a browser inside your managed domain (one the web
server authenticates), load any page and confirm you arrive already logged in as
your directory account, with no login form and no redirect. Keep `/user/login`
available for accounts that are not in the directory.
