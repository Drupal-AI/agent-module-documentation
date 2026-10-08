# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **LMS** module (`lms`), installed and configured — LMS SCORM adds SCORM
  support to it.

## Install with Composer

From the project root:

```bash
composer require drupal/lms_scorm -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer resolve and install
dependencies alongside it.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/lms_scorm -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en lms_scorm -y
```

## After enabling

Create a new **Activity Type** that uses the **LMS → SCORM** field, so activities
of that type can hold a SCORM package. You can then upload SCORM packages to those
activities within a course.

## Verify it worked

Create a SCORM activity, upload a small SCORM package, and play it as a test
learner — confirm the integrated player runs it and that progress/score is
recorded against the learner in the LMS. See
[How to use it](../index.md#how-to-use-it) for the full flow.

> **Note:** This release tracks the **1.1.x-dev** branch. Test it on a
> non‑production environment first.
