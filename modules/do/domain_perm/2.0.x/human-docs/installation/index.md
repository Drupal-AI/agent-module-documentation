# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`). The module
  overrides core's `UserRolesAccessPolicy`, which is why it needs 10.3+.
- A working **multi-domain setup** with a genuinely separate edit domain and
  public domain(s), and trusted host resolution — these are what make the
  hardening meaningful. The module itself declares no Drupal module dependencies.

There are no third-party PHP or Composer library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/domain_perm -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/domain_perm -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en domain_perm -y
```

## Verify it worked

Log in as an editor on your **edit domain** and confirm your roles and admin
access are intact. Then visit a **non-edit domain** as the same user: your
elevated roles should be gone, leaving only the exempt roles (by default
`anonymous`/`authenticated`). If stripping is not happening, revisit the edit
domain and exempt-role settings — see the
[main guide](../index.md#how-the-access-model-works) and the module's `README.md`.
