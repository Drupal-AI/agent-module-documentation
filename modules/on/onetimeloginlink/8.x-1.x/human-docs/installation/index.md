# Installation

## Requirements

- **Drupal 8.8, 9, or 10** (`core_version_requirement: ^8.8 || ^9 || ^10`).
- No other contrib modules, and no third‑party Composer or PHP libraries.

> **Heads‑up on names:** the Drupal.org project (and Composer package) is
> `onetimeloginlink`, but the module's **machine name is `onetime_loginlink`** —
> note the underscore. You install with the project name and enable with the
> machine name, as shown below.

## Install with Composer

From the project root:

```bash
composer require drupal/onetimeloginlink -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/onetimeloginlink -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable it by its **machine name**, `onetime_loginlink`:

```bash
drush en onetime_loginlink -y
```

## Grant the permission carefully

Go to **People → Permissions** and grant **`administer onetime_loginlink`** only
to roles you fully trust. This permission is declared *restrict access* precisely
because it lets a holder mint a login link for any account — an
account‑impersonation capability in practice.

## Verify it worked

Log in as a user who holds the permission and open
**Configuration → System → OneTime LoginLink**
(`/admin/config/system/onetime-loginlink/settings`). Enter a test account's
username or email, submit, and confirm a one‑time login URL is generated. Opening
that URL should log you in as the test user.
