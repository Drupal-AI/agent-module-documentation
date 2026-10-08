# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **PHP 8.3** or newer.
- The **Webform** module (`webform`), version **6.x**.
- The **GraphQL** module (`graphql`), version **5.x**.

Two optional modules unlock extra elements when installed: **Address** (for the
address element) and **Telephone Validation** (for validating phone numbers).

## Install with Composer

From the project root:

```bash
composer require drupal/graphql_webform -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and will pull in Webform and GraphQL if they aren't
already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/graphql_webform -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable it together with Webform and GraphQL:

```bash
drush en webform graphql graphql_webform -y
```

## Submodules

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **GraphQL Webform Captcha** | `graphql_webform_captcha` | API-friendly spam protection for decoupled forms. Enable it whenever your forms are publicly reachable — a form endpoint with no captcha is found and abused quickly, and the usual honeypot/time-based tricks don't survive a client that renders its own markup. |

Enable it with:

```bash
drush en graphql_webform_captcha -y
```

## Verify it worked

There is no settings page. Open GraphiQL or your GraphQL explorer and confirm
you can query a Webform's definition (its fields and labels) and that the
submission mutation is present in the schema. Then test an actual submission from
your front end and confirm validation errors and the confirmation message come
back as expected.
