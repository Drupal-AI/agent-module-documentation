# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **File** module (`file`).
- The **LMS** module (`lms`) — LMS XAPI extends it.
- Access to a **Learning Record Store (LRS)** — either an external LRS or the
  bundled `lrs_xapi` submodule (a minimalistic built-in store).

This is a **1.0.0-beta1** release and the project is minimally maintained, so test
it on a non‑production environment first.

## Install with Composer

From the project root:

```bash
composer require drupal/lms_xapi -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer resolve and install the
LMS and File dependencies alongside it.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/lms_xapi -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en lms_xapi -y
```

## Submodules — enable what you need

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **LMS XAPI Activity** | `lms_xapi_activity` | Emits xAPI statements for LMS activity events. |
| **LMS XAPI Lesson** | `lms_xapi_lesson` | Emits xAPI statements for LMS lesson events. |
| **LRS xAPI** | `lrs_xapi` | A minimalistic built-in Learning Record Store for storing scores and states — use it if you do not have an external LRS. |

Enable the ones you need, for example:

```bash
drush en lms_xapi_activity lms_xapi_lesson -y
```

## Verify it worked

After enabling and [configuring the LRS connection](../configuration/index.md),
have a test learner complete a tracked activity or lesson and confirm that a
matching xAPI statement arrives in your LRS.
