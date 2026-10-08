# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Field** module (`field`), enabled on every standard site.
- The **`giggsey/libphonenumber-for-php ~8.0`** PHP library — Composer installs this
  automatically when you require the module.
- For SMS **verification**: an SMS gateway, configured separately in your SMS
  framework (a per‑message cost).

This release is **1.0.0‑beta1** — a beta — so test it before relying on it in
production.

## Install with Composer

From the project root:

```bash
composer require drupal/phonenumber -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the
`giggsey/libphonenumber-for-php` library and any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/phonenumber -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en phonenumber -y
```

## Submodules — enable only what you need

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **PhoneNumber Validation** | `phonenumber_validation` | Checks that a number is well‑formed and belongs to the selected country. |
| **PhoneNumber Verification** | `phonenumber_verification` | The send‑a‑code / enter‑the‑code flow that proves the user controls the number (needs an SMS gateway). |

Enable them individually, for example:

```bash
drush en phonenumber_validation -y
drush en phonenumber_verification -y
```

Both submodules require the base PhoneNumber module, which is already present once
you have installed it above.

## Verify it worked

Go to **Structure → Content types → *(any type)* → Manage fields**, click **Create
a new field**, and confirm that **Phone number** appears in the list of field
types. If it does, the module is installed and ready — see "How to use it" on the
[overview page](../index.md) to add and configure a field.
