# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- Core's **Options** (`options`) and **User** (`user`) modules — part of Drupal
  core.
- The **Encrypt** module (`encrypt`) — used to store connection credentials
  encrypted. You'll also need an **encryption backend**; the module suggests
  [Key management: KMS](https://www.drupal.org/project/encrypt_kms),
  [Real AES](https://www.drupal.org/project/real_aes), or Sodium.
- If you want a transport other than the bundled IMAP, install the matching add-on
  (for example **Mail Group Amazon SES** or a Mailgun connection module).

## Install with Composer

From the project root:

```bash
composer require drupal/mailgroup -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update the
Encrypt dependency as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/mailgroup -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mailgroup -y
```

Options, User, and Encrypt are enabled automatically as dependencies if they
aren't already.

## Verify it worked

Log in as an administrator with the **Administer mail groups** permission. You
should be able to create a Mail Group Type and a Mail Group. Before you can store
connection credentials, set up an encryption profile — see
[Configuration](../configuration/index.md).
