# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- The **LMS** module (`lms`) — LMS AI extends it.
- The **AI Providers API** module — this supplies the AI provider connection and
  API key that LMS AI uses. Note it does **not** require the full AI module
  package.

This is a **1.0.0-alpha2** release, so test it on a non‑production environment
first.

## Install with Composer

From the project root:

```bash
composer require drupal/lms_ai -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer resolve and install the
LMS dependency alongside it. Install the AI Providers API module the same way if
it is not already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/lms_ai -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en lms_ai -y
```

Also enable the AI activity-answer submodule that ships with it (the one that
provides the AI text-field activity) so you have a usable activity type.

## Connect an AI provider

Before the AI features will work, configure an AI provider and its **API key** in
the **AI Providers API** module. Keep the key in an environment variable or a Key
entity — never hard-code or commit it. Remember that each evaluation makes an
outbound, potentially billable call and sends learner answer text to the
provider.

## Verify it worked

With LMS, the AI Providers API, and LMS AI all enabled and a provider configured,
add an AI text-field activity to a course, submit a test answer, and run cron —
the AI feedback and score should appear after the cron run completes.
