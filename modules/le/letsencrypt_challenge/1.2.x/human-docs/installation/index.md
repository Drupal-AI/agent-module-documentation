# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No other modules and no third‑party PHP libraries are required.
- An ACME client you run in **manual** mode (certbot, lego, etc.) to generate the
  challenge value you will paste into Drupal.

> **Heads‑up:** the release documented here is **1.2.0‑beta1**. Test it on a
> staging site before you rely on it for a production certificate renewal.

If your site runs on **Apache**, you will typically need to tweak `.htaccess` so
requests to `/.well-known/acme-challenge/…` reach Drupal instead of being handled
(or blocked) by the web server first — see the note in the project's issue
[#2408321](https://www.drupal.org/project/letsencrypt_challenge).

## Install with Composer

From the project root:

```bash
composer require drupal/letsencrypt_challenge -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/letsencrypt_challenge -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en letsencrypt_challenge -y
```

There are no submodules to consider — this is a single, self‑contained module.

## Verify it worked

1. Log in as an administrator and visit
   `/admin/config/letsencrypt_challenge/challenge` — you should see the challenge
   form.
2. Paste a test value, save, then request
   `http://your-site/.well-known/acme-challenge/anything` in a browser or with
   `curl`. You should get the value you saved back as plain text. If Apache
   returns a 404 or a directory‑listing error instead, revisit the `.htaccess`
   tweak above.

Next, see [Configuration](../configuration/index.md) for the challenge form field
by field.
