# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **[Redirect](https://www.drupal.org/project/redirect)** module
  (`redirect`) — this module enhances the revision routes Redirect exposes.
  Composer pulls it in for you.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/redirect_revisions_ui -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies — including the Redirect module — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/redirect_revisions_ui -W`, `ddev
> drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en redirect_revisions_ui -y
```

## Grant the permissions

The revision tab only appears for users who hold the matching permission. At
**People → Permissions** (`/admin/people/permissions`), grant to trusted roles as
needed:

- **View any redirect history**
- **View any redirect revisions**
- **Revert any redirect revisions**
- **Delete any redirect revisions**

## Verify it worked

Edit any redirect at **Configuration → Search and metadata → URL redirects**. A
**Revisions** tab should now be visible (for a user with the view permission),
listing the redirect's revision history with view, revert, and delete actions
according to the permissions you granted.
