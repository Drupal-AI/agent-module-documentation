# Installation

## Requirements

- **Drupal 10.3 or newer** (`core_version_requirement: >=10.3`).
- **PHP 8.1 or newer**.
- The **[ECA](https://www.drupal.org/project/eca)** module, version `^2.1.11 || ^3.0`
  — ECA Helper is an add‑on to ECA and does nothing without it.
- ECA's **ECA Form** submodule (`eca_form`), which the form‑related actions rely on.
  It is enabled automatically as a dependency.

## Install with Composer

From the project root:

```bash
composer require drupal/eca_helper -W
```

This installs ECA Helper together with its ECA dependency. The `-W`
(`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/eca_helper -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en eca_helper -y
```

Or enable **ECA Helper** from *Extend* (`/admin/modules`). Drupal will enable ECA and
`eca_form` at the same time if they aren't already on.

You will also want an ECA "modeller" (such as BPMN.iO) to build models visually —
see the ECA project's own documentation for choosing and installing one.

## Optional submodule — ECA Helper Workflow

The project ships an **ECA Helper Workflow** submodule that adds actions for reading
and setting an entity's **Content Moderation** workflow state. Enable it only if you
use Content Moderation:

```bash
drush en eca_helper_workflow -y
```

## After enabling

There is nothing to configure and no permissions to grant for ECA Helper itself — its
actions and events become available inside the ECA modeller immediately. Build or edit
an ECA model and add the **ECA Helper: …** actions or the custom events — see
[How to use it](../index.md#how-to-use-it). Access is governed by ECA's own
permissions, so restrict who may administer ECA models.
