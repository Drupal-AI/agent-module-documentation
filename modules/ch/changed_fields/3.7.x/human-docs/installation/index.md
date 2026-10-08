# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No third‑party PHP or JavaScript libraries.
- No other module dependencies — this is a self‑contained developer API.

## Install with Composer

From the project root:

```bash
composer require drupal/changed_fields -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/changed_fields -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en changed_fields -y
```

Enabling the base module alone does nothing visible — it provides an API for
other code to use.

## Submodules — the built‑in examples

The project ships two demo submodules that double as its documentation. Enable
them on a development site to see the API in action, then read their source:

| Submodule | Machine name | What it demonstrates |
|-----------|--------------|----------------------|
| **Basic usage** | `changed_fields_basic_usage` | The minimal observer setup — registering an observer and reacting to a structured diff of changed fields. |
| **Extended field comparator** | `changed_fields_extended_field_comparator` | Providing a custom `FieldComparator` plugin so comparison logic is correct for a specific field type. |

For example, to enable the basic example:

```bash
drush en changed_fields_basic_usage -y
```

## Verify it worked

Because the module has no UI, the best check is via the examples: enable
`changed_fields_basic_usage`, edit and save an entity on a development site, and
confirm the example code reports the changed fields (for instance in the log or
in code you add). On a production site, simply confirm the module is enabled and
that the module that depends on it is functioning.
