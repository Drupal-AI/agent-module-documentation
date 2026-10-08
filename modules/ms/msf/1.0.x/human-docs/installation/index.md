# Installation

## Requirements

Multistep Form Advanced needs:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Field Group** module (`field_group`) — this is the engine the *Form step*
  formatter plugs into.
- The **Account Field Split** module (`account_field_split`) — this lets the user
  registration form's account fields be split across steps.

There are no PHP extension or third‑party library requirements. Composer will
pull in Field Group as a dependency; Account Field Split may need to be required
explicitly (see below).

## Install with Composer

From the project root:

```bash
composer require drupal/msf -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. If Composer does not resolve Account Field Split
automatically, require it as well:

```bash
composer require drupal/account_field_split -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/msf -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en msf -y
```

Drupal enables **Field Group** and **Account Field Split** as dependencies at the
same time.

## Verify it worked

Go to **Structure → Content types → *(any type)* → Manage form display**. When you
add or edit a field group there, the **Format** select for that group should now
offer **Form step** as an option. That confirms the formatter is available and
you can begin building your wizard — see "How to use it" on the
[overview page](../index.md).
