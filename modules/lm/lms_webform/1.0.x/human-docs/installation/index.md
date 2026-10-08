# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **Webform** module (`webform`) — supplies the forms.
- The **LMS** module (`lms`), **version 1.1.3 or newer** — LMS Webform extends it.

This is a **1.0.0-beta2** release, so test it on a non‑production environment
first.

## Install with Composer

From the project root:

```bash
composer require drupal/lms_webform -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer resolve and install the
Webform and LMS dependencies alongside it.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/lms_webform -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en lms_webform -y
```

Drush will enable the Webform and LMS dependencies if they are not already on.

## Verify it worked

Build a simple webform, add a webform activity to a course pointing at it, and
complete it as a test learner — confirm the submission is captured and the
learner's course progress reflects it. See
[How to use it](../index.md#how-to-use-it) for the full flow.
