# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).
- The **Feeds** module (`feeds`).
- The **LDAP Servers** module (`ldap_servers`) — provides the directory connection.
- The **LDAP Query** module (`ldap_query`) — provides the query the fetcher runs.
- A reachable **LDAP / Active Directory** server, and bind credentials for it.

This is a **beta** release, so test it before relying on it in production. The LDAP
modules also require PHP's LDAP extension to be available on your server.

## Install with Composer

From the project root:

```bash
composer require drupal/feeds_ldap -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Feeds and the LDAP
modules and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/feeds_ldap -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en feeds_ldap ldap_servers ldap_query feeds -y
```

Drupal enables the dependencies automatically, but enabling them explicitly is
harmless and makes the requirement clear.

## A note on credentials

The LDAP bind credentials are configured in the LDAP Servers module. Store and
protect them, and prefer **LDAPS or StartTLS** so the connection to the directory
is encrypted.

## Verify it worked

With an LDAP server and query configured under **Configuration → People → LDAP**,
create a feed type at **Structure → Feed types** and confirm that the **LDAP**
fetcher and parser appear in the fetcher and parser options.
