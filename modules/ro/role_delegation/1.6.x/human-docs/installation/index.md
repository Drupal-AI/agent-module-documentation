# Installation

## Requirements

- **Drupal 10.3+ or Drupal 11** (`core_version_requirement: ^10.3 || ^11`).
- **User** (`user`) — part of Drupal core and enabled on every site, so there is nothing extra to install. This is the module's only dependency.

Role Delegation ships no submodules and needs no external PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/role_delegation -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/role_delegation -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en role_delegation -y
```

That's all it takes — there is no settings form to configure. The module immediately generates its *assign {role} role* permissions and the *assign all roles* permission.

**Verify it worked.** Go to **People → Permissions** (`/admin/people/permissions`) and look for the Role Delegation section — you should see an *Assign all roles* checkbox plus one *Assign {role} role* checkbox for each of your site's roles. Grant the ones you want, and a **Roles** tab will appear on each user's profile at `/user/{user}/roles`.
