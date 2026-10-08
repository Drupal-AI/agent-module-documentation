# Installation

## Requirements

AI Policy Gateway governs calls made through the AI module, so it needs:

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- The **AI** module (`ai`) — the framework whose calls this module governs.
- Core's **System**, **User**, and **Datetime** modules (enabled automatically).

Several modules are **optional** and unlock extra integration when present: AI
Model Registry (for model metadata), AI Agents, and the AI observability/logging/
decision-log modules. None of them are required to get started.

There are no extra PHP libraries to install, and — by design — the module holds no
AI provider credentials of its own.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_policy_gateway -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update shared
dependencies such as the AI module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ai_policy_gateway -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_policy_gateway -y
```

On enable it ships ready-made policy profiles (`public`, `internal`,
`local_only`, `high_risk`, `regulated`) and example rules as default
configuration, so governance is active with a sensible starting point.

## After enabling

1. Grant the permissions: **Administer AI Policy Gateway** (restricted) to
   administrators, **View AI Policy Gateway reports** to those who should read the
   decision audit, and **Approve AI Policy Gateway actions** (restricted) to the
   reviewers who work the approvals queue.
2. Head to [Configuration](../configuration/index.md) to review and adjust the
   bundled profiles and rules.
