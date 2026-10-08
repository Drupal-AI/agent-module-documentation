# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The contributed **Token** module (`drupal/token`) — install and enable it if it
  is not already present.

There are no other Composer or PHP library requirements.

> **Note on coverage:** this module is *not* covered by Drupal's security advisory
> policy. Weigh that against your site's requirements before deploying it to
> production.

## Install with Composer

From the project root:

```bash
composer require drupal/revision_author_tokens -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including the Token module, if you do not already have it.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/revision_author_tokens -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en revision_author_tokens -y
```

Drupal will also enable the Token module if it is required and not yet on.

## Verify it worked

No further setup is needed — the tokens are available immediately. To confirm, open
any token browser (for example on a Metatag or Pathauto pattern field) and look
under the **Nodes** group for `[node:revision-author]`,
`[node:revision-author-uid]`, and `[node:revision-author-email]`. See "How to use
it" on the [overview page](../index.md), including the privacy caution.
