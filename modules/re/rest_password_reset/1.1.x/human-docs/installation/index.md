# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **RESTful Web Services** module (`rest`) and core's **User** module
  (`user`).
- The contributed **REST UI** module (`restui`) — this is a declared dependency here,
  and you use it to activate the module's custom endpoints and open them to anonymous
  callers.
- A decoupled front end (for example a React app) is a practical hard requirement:
  the reset link points at a page you build in that front end.

## Install with Composer

From the project root:

```bash
composer require drupal/rest_password_reset -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. This pulls in REST UI as a dependency; if you need it
explicitly, `composer require drupal/restui -W`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/rest_password_reset -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en rest_password_reset -y
drush en restui -y
```

## Activate the endpoints and open them to anonymous callers

Because a user requesting a password or username is not logged in, these endpoints
must be reachable by anonymous callers:

1. Go to **Configuration → Web services → REST**
   (`/admin/config/services/rest`).
2. Enable the module's three resources (the username request, the password/reset-link
   request, and the reset completion). Choose the serialisation format(s) and set the
   authentication method — **cookie authentication** is recommended so your front end
   can GET and POST directly without first authenticating.
3. Go to **People → Permissions** (`/admin/people/permissions`) and grant the
   *Anonymous user* role access to these resources, so an end user who is locked out
   can still use them.

Then set the reset-link target in the module's settings — see
[Configuration](../configuration/index.md).

## Verify it worked

Request a reset link for a known account:

```
GET https://your-site/user/password/user@example.com
```

You should get back the generic "If there is an active user…" message (the same
message whether or not the email exists), and the account should receive a
reset email whose link points at the front-end page you configured.
