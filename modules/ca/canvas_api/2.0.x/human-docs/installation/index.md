# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- Module dependencies:
  - **Canvas LMS** (`canvas_lms`) — the base Canvas integration module.
  - **Key** (`key`) — stores the Canvas API token/credentials securely.
- A **Canvas LMS** instance and an **API token** with the access you need.
- No additional third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/canvas_api -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies as
needed, including Canvas LMS and Key.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/canvas_api -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en canvas_api -y
```

Drupal enables Canvas LMS and Key at the same time.

## Store your Canvas API token with Key

Keep the Canvas API token out of exported configuration by storing it as a **Key** entity
backed by an environment variable. With DDEV, set the variable once and reference it from a
Key:

```bash
ddev dotenv set .ddev/.env --canvas-api-token=<value>   # never commit .ddev/.env
ddev restart
```

Then create a Key that reads that environment variable (via Key's environment provider), and
configure the Canvas LMS integration to use it. This way the secret lives in the environment,
not in the database or in version control.

## Verify it worked

Use the module's **tester page** to make a simple Canvas API call (for example, listing users
in a known course), or call the `canvas_api` service from a small snippet as shown in the
overview. A successful response confirms the credentials and connection are working. Remember
that responses may include educational PII / FERPA‑relevant data — handle it accordingly.
