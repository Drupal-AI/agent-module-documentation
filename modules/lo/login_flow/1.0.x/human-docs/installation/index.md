# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **User** module (enabled by default) — the only dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/login_flow -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/login_flow -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the base module

```bash
drush en login_flow -y
```

On its own, the base module only replicates Drupal's standard
username‑and‑password login (via its default Password Authentication plug‑in). To
get any new behaviour, enable a plug‑in provider.

## Sub‑modules — the login behaviour lives here

Enable the sub‑module(s) that provide the login method you want:

| Sub‑module | What it adds |
|------------|--------------|
| **Login Flow Email Link** | Passwordless login via a one‑time link sent by email. |
| **Login Flow Email Code** | Passwordless login via a code sent by email, or an additional email‑code security step on top of username‑and‑password login. |

For example:

```bash
drush en login_flow_email_code -y
```

(Any other module that implements a Login Flow plug‑in works the same way — enable
it and it appears in the plug‑in list.)

## Verify it worked

Open the Login Flow configuration form and confirm your enabled plug‑ins appear in
the list with their evaluation order. Then test a login against an account the
plug‑in is configured to handle, and confirm the expected step (for example, an
emailed link or code) is triggered.
