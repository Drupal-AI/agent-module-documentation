# Installation

## Requirements

Auto Login URL is lightweight. It needs:

- **Drupal 10.3+ or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **System** and **User** modules — always present in a Drupal install.

There are no third-party Composer or PHP library requirements.

**Optional but recommended:** the [Token](https://www.drupal.org/project/token)
module (`drupal/token`). With it enabled you get the
`[user:auto-login-url-token]` and `[user:auto-login-url-account-edit-token]`
tokens, which render ready-made login links inside email templates.

**Prerequisite for security:** the module derives its tokens partly from your
site's `hash_salt` (in `settings.php`). A properly installed Drupal already has a
unique hash salt; keep it secret and consistent across environments where the
links must work.

## Install with Composer

From the project root:

```bash
composer require drupal/auto_login_url -W
```

Add the Token module too if you want the email-template tokens:

```bash
composer require drupal/token -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/auto_login_url -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en auto_login_url -y
```

If you installed Token, enable it as well:

```bash
drush en token -y
```

## After enabling

1. Go to **People → Permissions** and grant **Administer auto login url** (and,
   where relevant, **Use auto login url**) to trusted roles only — both are
   marked security-restricted.
2. Visit **People → Auto Login URL** (`/admin/people/autologinurl`) to review the
   defaults before you start minting links. See
   [Configuration](../configuration/index.md).

A random module secret is generated automatically the first time a link is
created, so there is nothing else to set up to get started.
