# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **Simple OAuth** module (`simple_oauth`) — this is a required dependency, and it
  should already be installed and configured as your OAuth provider. The account
  picker enhances Simple OAuth's authorize flow and does nothing without it.
- No additional PHP libraries or third‑party Composer packages.

## Install with Composer

From the project root:

```bash
composer require drupal/simple_oauth_account_picker -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. If Simple OAuth is not already present, install it too:

```bash
composer require drupal/simple_oauth drupal/simple_oauth_account_picker -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simple_oauth_account_picker -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_oauth_account_picker -y
```

## Verify it worked

With Simple OAuth configured and this module enabled, start an Authorization Code Grant
from a client application. On the OAuth authorize page you should now see the account
picker — with options to continue as the current account, reuse a previously used
account, or log in with a different one — instead of a plain login form. As you test,
confirm that choosing a different account requires a real login and that the tokens
issued belong to the authenticated session.
