# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- **Domain** (`domain`) — the Domain Access module, which provides the domain
  records and the per-user domain assignments the login check reads.
- No separate PHP library requirements.

> **Release / coverage note:** the documented release is **8.x-0.1-rc4** and the
> project is **not covered** by Drupal's security advisory policy. Test it before
> relying on it as a security control on a live site.

## Install with Composer

From the project root:

```bash
composer require drupal/domain_login_filter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, including the Domain module if it is not already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/domain_login_filter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en domain_login_filter -y
```

The login restriction is active immediately — there is no settings form to
configure.

## Set up users' domain assignments

Because the module reads each user's Domain Access assignments to decide where they
may log in, make sure those assignments are correct:

1. Confirm the Domain module is configured and your domains exist.
2. Assign each user to the domain(s) they should be able to log in on (on the user
   account, or in bulk via Domain Access).

## Verify it worked

Take a user assigned to Domain A but not Domain B. Try to log in on Domain B — the
login should be refused with an error such as "The username *name* has not been
activated or is blocked on this domain," and authentication should not complete.
The same user logging in on Domain A should succeed.
