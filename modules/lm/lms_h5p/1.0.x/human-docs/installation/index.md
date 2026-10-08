# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **LMS** module (`lms`) — LMS H5P extends it.
- The **H5P** module — provides the interactive-content framework this integrates
  with.
- The **LMS XAPI** module — needed so H5P answers can be recorded (as xAPI
  statements) and scored in Drupal.

This is a **1.0.0-alpha4** release, so test it on a non‑production environment
first.

## Install with Composer

From the project root:

```bash
composer require drupal/lms_h5p -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer resolve dependencies. If
the H5P and LMS XAPI modules are not already present, install them the same way.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/lms_h5p -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable LMS H5P together with its companions:

```bash
drush en lms_h5p -y
```

Make sure **H5P** and **LMS XAPI** are also enabled — the module needs both to
author content and to record/score results.

## Verify it worked

With LMS, H5P, LMS XAPI, and this module enabled, add an H5P activity to a course,
complete it as a test learner, and confirm the result is recorded and scored in
Drupal. See [How to use it](../index.md#how-to-use-it) for the full flow.
