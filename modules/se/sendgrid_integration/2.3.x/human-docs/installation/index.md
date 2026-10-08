# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Mailsystem** module (`mailsystem`, version 4.x or newer). This is a hard
  dependency — it is how you actually select SendGrid as the mail system. Composer
  installs it for you.
- Two PHP libraries, installed automatically by Composer: **`fastglass/sendgrid`**
  (`~2.0.0`, the SendGrid API client) and **`html2text/html2text`** (`^4.3.1`, used
  to generate a plain‑text alternative for HTML mail). PHP's **`json`** extension is
  also required (it is part of a standard PHP install).
- A **SendGrid account** and an **API key** with mail‑send permission.
- *(Optional but recommended)* the **Key** module, so you can store the API key as a
  Key entity rather than in plain config.

## Install with Composer

From the project root:

```bash
composer require drupal/sendgrid_integration -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Mailsystem and the
SendGrid/html2text libraries and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sendgrid_integration -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sendgrid_integration -y
```

Mailsystem is enabled as a dependency. If you want to store the API key as a Key
entity, also install and enable the Key module:

```bash
ddev composer require drupal/key
drush en key -y
```

## Submodule — SendGrid Integration Reports

The project ships one optional sub‑module, **`sendgrid_integration_reports`**, which
adds a statistics/reporting dashboard built from SendGrid's v3 stats API. Enable it
if you want in‑Drupal SendGrid stats:

```bash
drush en sendgrid_integration_reports -y
```

## Next step

Enabling the module does **not** route your mail through SendGrid yet — you still
have to add your API key and select SendGrid as the mail system in Mailsystem. See
[Configuration](../configuration/index.md).
