# Installation

## Requirements

PRLP is lightweight. It needs:

- **Drupal 10.3+ or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's User module (part of standard Drupal) — it enhances the core
  password-reset flow. There are no other module dependencies.
- No third-party Composer packages, PHP extensions, or JavaScript libraries.

The **PRLP Password Policy** submodule (optional, see below) additionally needs
the contrib [Password Policy](https://www.drupal.org/project/password_policy)
module.

## Install with Composer

From the project root:

```bash
composer require drupal/prlp -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/prlp -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en prlp -y
```

That's all it takes. From now on the password-reset landing page includes the *Set
New Password* field, with the field required by default. No further configuration
is needed.

## Submodule — PRLP Password Policy

If your site uses the contrib **Password Policy** module and you want its strength
rules enforced on the reset landing page (not just on the account form), enable the
bundled integration submodule:

```bash
drush en prlp_password_policy -y
```

It requires the base PRLP module (already present) and the Password Policy module.

## Verify it worked

Trigger a password reset (for example from `/user/password`), open the reset link,
and confirm the landing page now shows a **Set New Password** field. To adjust
whether that field is required or where users land afterward, see
[Configuration](../configuration/index.md).
