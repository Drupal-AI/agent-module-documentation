# Installation

## Requirements

- **Drupal 11.3+** (`core_version_requirement: ^11.3`) — it relies on plugin
  constructor autowiring introduced in 11.3.
- Core's **Datetime** module (`datetime`).
- **Symfony Messenger** (`sm`) and **Message Scheduler** (`sm_scheduler`).
- A **running Messenger consumer** to process the recurring scan and batches.

Composer pulls in the module dependencies for you.

## Install with Composer

From the project root:

```bash
composer require drupal/sm_entity_scheduler -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in `sm` and
`sm_scheduler` and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sm_entity_scheduler -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sm_entity_scheduler -y
```

## What next

Add (or reuse) a date field on the entity bundle you want to schedule, create a
schedule config entity pointing at that field, and run a Symfony Messenger
consumer so the schedule is processed. See the main guide's "How to use it"
section for the walkthrough.
