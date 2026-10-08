# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9.0 || ^10.0`).
- A **decoupled architecture** where Drupal is hosted on a **subdomain of your
  front end**, so the browser can share the session cookie between the two (for
  example, front end at `www.myfrontend.com`, Drupal at `app.myfrontend.com`).

There are no third‑party Composer or PHP library requirements, but to get the full
benefit you will typically pair it with a couple of other pieces (see below).

## Install with Composer

From the project root:

```bash
composer require drupal/decoupled_cookie_auth -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/decoupled_cookie_auth -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en decoupled_cookie_auth -y
```

## Recommended companions

These are optional but commonly used alongside the module:

- **Core REST user registration** — to allow decoupled registration, enable the
  *User registration* REST resource at
  `/admin/config/services/rest` and grant the anonymous role access to it.
- **Mail Login** (`mail_login`, 8.x‑2.x) — lets users log in with just an email
  and password, which pairs naturally with this module's email‑only registration.
- **Core logout‑token patch** (`https://drupal.org/node/3004421`) — provides a
  route for the front end to retrieve a logout token.

## Verify it worked

After enabling and completing the [Configuration](../configuration/index.md) steps
(both the admin form *and* the `services.*.yml` cookie‑domain change), register a
test user through the JSON registration endpoint from your front end. With email
verification off, the newly registered user should be logged in automatically, and
a password‑reset request should redirect to your front end's password‑reset page
with the `pass-reset-token` query parameter appended.
