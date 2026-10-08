# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Commerce Giftcard** (`commerce_giftcard`) — the 2.x line.
- **Commerce Email** (`commerce_email`).

Both are Drupal Commerce contrib modules and are pulled in as dependencies.

> **About the patch:** version 2.x requires a patch on Commerce Giftcard that adds
> the `commerce_giftcard.giftcard_activated` event and ensures activation happens
> only after payment is confirmed. In 2.x this patch is applied **automatically
> via Composer**, so there is nothing to apply by hand — just make sure your
> project allows Composer patching (the `cweagans/composer-patches` plugin, which
> Commerce projects commonly already use).

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_giftcard_mail -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in Commerce Giftcard and Commerce Email.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_giftcard_mail -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_giftcard_mail -y
```

## Verify it worked

Go to **Commerce → Configuration → Emails**
(`/admin/commerce/config/emails`) and start a new email — the **Giftcard
activated** event should be available as a trigger. Create that email as described
in the [main guide](../index.md#how-to-use-it), then buy and pay for a test gift
card to confirm the mail is delivered.
