# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- Core's **RESTful Web Services** module (`rest`) and core's **Serialization** module
  (`serialization`) — `rest` is a declared dependency and pulls serialization in.
- The contributed **REST UI** module (`restui`) is strongly recommended for
  activating and inspecting the endpoints.
- A working outbound **mail** configuration on the site — the flow depends on the
  verification email actually being delivered.

Note the project is **not covered** by Drupal's security advisory policy; weigh that
for a registration-related module and test carefully.

## Install with Composer

From the project root:

```bash
composer require drupal/rest_register_verify_email -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. Add REST UI if you do not already have it:

```bash
composer require drupal/restui -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/rest_register_verify_email -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en rest_register_verify_email -y
drush en restui -y
```

## Activate the endpoints and open them to anonymous callers

Registration and verification happen before a user has an account, so the endpoints
must be reachable anonymously:

1. Go to **Configuration → Web services → REST**
   (`/admin/config/services/rest`).
2. Enable the module's resources — the register endpoint, the verify endpoint, and
   the resend-token endpoint. Choose the serialisation format(s) and an appropriate
   authentication method for anonymous use.
3. Go to **People → Permissions** (`/admin/people/permissions`) and grant the
   *Anonymous user* role access to these resources.
4. Confirm your site's account email settings under **Configuration → People →
   Account settings** are sensible, since the verification token is delivered by
   email.

## Verify it worked

1. POST registration data (including any required `field_*` fields) to the register
   endpoint. The response should indicate the account was created, and the new
   account should be **blocked**.
2. Check that the verification email arrives with a token.
3. POST the username plus the token to the verify endpoint — the account should
   become active. Do all of this over HTTPS, since the token is a bearer credential.
