# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- The **`kreait/firebase-php`** library (version 8) — Composer installs this
  automatically as part of requiring the module, since Firebase PHP is a wrapper
  around it.
- A **Firebase project** and a **service-account credential** for it (a JSON key
  from the Firebase/Google Cloud console).

## Install with Composer

From the project root:

```bash
composer require drupal/firebase_php -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the
`kreait/firebase-php` library and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/firebase_php -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en firebase_php -y
```

Nothing changes visibly — the module simply makes the Firebase service available
for other code to inject.

## Provide the service-account credential securely

The Firebase service-account credential is a **highly privileged secret**: the
Admin SDK bypasses Firebase's security rules, so treat the key with the same care
as a production database password.

- **Never** hard-code the credential in code or commit it to version control.
- Store it as a **secret** outside the repository. With DDEV, keep the value in
  `.ddev/.env` (which must stay out of version control) using DDEV's dotenv
  command, then `ddev restart` so the container picks it up. Reference it from
  Drupal via an environment variable or, where supported, a **Key** entity backed
  by the environment provider (install the Key module if needed).
- **Restrict** which code can use the service, and scope the Firebase credential
  as narrowly as your use case allows.

## Verify it worked

Confirm the module is enabled with `drush pm:list --status=enabled | grep
firebase_php`, and confirm Composer installed the library
(`composer show kreait/firebase-php`). Beyond that, the module is exercised only by
code that injects and calls the Firebase service — there is no admin screen to
click through.
