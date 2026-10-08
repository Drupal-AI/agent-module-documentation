# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The contributed **Token** module (`token`) — TaaS builds on it, so it must be
  present and enabled.

There are no PHP library or extension requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/taas -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Token module
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/taas -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en taas -y
```

If the Token module is not yet enabled, enable it too (`drush en token -y`) — or
let the `-W` install above bring it in.

## Verify it worked

There is no admin page to check. TaaS is working once it is enabled and you have
registered a token class and service in your own module (see the
[main guide](../index.md)) — your custom token should then resolve wherever tokens
are supported. Note that this is a contributed module and is not covered by
Drupal's security advisory policy.
