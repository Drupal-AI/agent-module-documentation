# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- **Drush** (this is a Drush‑focused module). Some contrib‑command hooks have
  their own needs — for example the **Devel** rows require Drush **13.7+**, and
  compression for a contrib command only applies when that module is installed.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/dtk -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/dtk -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dtk -y
```

Enabling the module on its own **changes nothing** for a human at a terminal —
compression is entirely opt‑in. Turn it on per command, per session, or
permanently as described in the ["How to use it"](../index.md#how-to-use-it--enabling-compression)
section.

## Verify it worked

Run a supported command with the flag and compare it to the native output:

```bash
drush pml --ai-compress
```

The list should come back as a compact CSV with a reduced set of fields. Running
`drush pml` without the flag (and without `DTK_COMPRESS`/config enabled) returns
Drush's normal output, confirming compression is opt‑in.
