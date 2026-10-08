# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Opis JSON Schema** PHP library, pulled in automatically by Composer when
  you require the module.
- A set of your own **JSON schema files** (see below) — the module validates
  against schemas you provide.

> **Note on security coverage:** this project is not currently covered by
> Drupal's security advisory policy (`security_advisory_coverage: not-covered`).
> Factor that into your decision to use it on a production site.

## Install with Composer

From the project root:

```bash
composer require drupal/json_schema_validator -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/json_schema_validator -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Create your JSON schemas

Before the module is useful you need schema files:

1. Write your JSON schemas. **All of them must use the same domain** for `"$id"`.
2. Name each file `<name>.schema.json`, where `<name>` is the schema's `"$id"`
   with the domain removed.
3. Put all the schema files in the **same directory**.

## Enable the module

```bash
drush pm:install json_schema_validator
```

(Equivalently, `drush en json_schema_validator -y`.)

## Point the module at your schemas

Go to the settings page at `/admin/config/system/json_schema_validator` and set
the **Schema Domain** and **Schema Directory Path** — see
[Configuration](../configuration/index.md).

## Verify it worked

From a custom module, encode some test data and call
`json_schema_validator.validator`'s `validateJsonSchema()` with your schema name
(the `"$id"` minus the domain and the `.schema.json` suffix). Valid data should
pass; invalid data should throw. If validation isn't happening at all, confirm the
**Validation Enabled** kill switch is on and that the schema domain/path are
correct.
