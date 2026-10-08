# Installation

## Requirements

- **Drupal 11.2 or newer** (`core_version_requirement: ^11.2`).
- The **FlowDrop** suite — `flowdrop`, plus its session, workflow, and node‑processor
  modules (`flowdrop_session`, `flowdrop_workflow`, `flowdrop_node_processor`, and the
  playground/UI‑components modules FlowDrop pulls in). These are enabled automatically
  as dependencies.

There are no extra Composer library or PHP version requirements.

> **Security coverage.** This is an early (alpha) release that is **not covered by
> Drupal's security advisory policy**. Keep it to trusted users and test before using
> it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/flowdrop_node_session -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the FlowDrop
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/flowdrop_node_session -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en flowdrop_node_session -y
drush cr
```

The cache rebuild (`drush cr`) makes sure the new route and node type are registered.
Drupal will enable the required FlowDrop modules as dependencies if they are not
already on.

## Verify it worked

Open a workflow in the FlowDrop editor and confirm the **EntityContext** node is
available in the node palette. Then try launching the entity playground URL for a
workflow, for example
`/admin/flowdrop/workflows/{workflow_id}/playground/entity?entity_type=node&entity_id=1`
— the session should open pre‑loaded with that node's data.
