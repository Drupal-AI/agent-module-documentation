# Installation

## Requirements

- **Drupal 10.3+ or 11** (`core_version_requirement: ^10.3 || ^11`).
- **ECA** (`eca`) — the Event-Condition-Action workflow framework.
- **Salesforce Suite** — at minimum `salesforce` and `salesforce_mapping`.

Optional, but they unlock extra features:

- **Salesforce Push** — required for the push events and the push action.
- **Salesforce Pull** — required for the pull events and the pull action.

The module handles the optional modules' absence gracefully: push/pull events
simply do not appear unless the matching module is enabled. There are no submodules
of its own and no third-party PHP libraries beyond what the Salesforce Suite and
ECA require.

## Install with Composer

From the project root:

```bash
composer require drupal/salesforce_eca -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in ECA and the
Salesforce Suite and update shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/salesforce_eca -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en salesforce_eca -y
```

To also enable the optional push/pull integrations:

```bash
drush en salesforce_push salesforce_pull -y
```

## Set up the Salesforce connection separately

Salesforce ECA relies on the Salesforce Suite for the actual Salesforce
connection and its credentials — this module never handles them. Make sure the
Salesforce Suite is authorized to your org (store the credentials securely, ideally
environment-backed) before you expect any Salesforce events to fire.

## Verify it worked

Go to **Configuration → Workflow → ECA** (`/admin/config/workflow/eca`), create or
edit a model, and add a trigger. You should see events prefixed **"Salesforce:"** in
the list — their presence confirms the integration is active. If you only see a
subset, check that the Salesforce Push and/or Pull modules are enabled for the
push/pull events you expect.
