# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`). Confirm
  compatibility before using it on Drupal 11.
- Core's **User** module (`user`) — always present on a Drupal site. The module builds
  on core's user authentication controller, so a working core login (and, in
  practice, the core REST/serialization stack for JSON handling) is assumed.

There are no third-party Composer or PHP library requirements. Note the project is
**not covered** by Drupal's security advisory policy, which is worth weighing for an
authentication-related module.

## Install with Composer

From the project root:

```bash
composer require drupal/rest_mail_login -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/rest_mail_login -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en rest_mail_login -y
```

The `POST /user/email-login` route is available immediately — there is nothing to
enable in the REST configuration or permissions pages.

## Verify it worked

Send a JSON login request for a real account:

```
POST https://your-site/user/email-login?_format=json

{"mail": "user@example.com", "pass": "the-password"}
```

A correct email and password return the same JSON payload as Drupal's standard
login (including a CSRF token and the current user info). A wrong password returns an
authentication error; an email that matches no account returns a `400`. Always make
these requests over HTTPS.
