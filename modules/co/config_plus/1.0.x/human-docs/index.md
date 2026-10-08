# Config Plus — manual setup guide

**Config Plus** (`config_plus`) is a small developer‑facing toolkit for keeping
configuration *clean* on sites that manage config as code. It does three things: it provides
a service for installing new configuration that a module ships (as if Drupal's own installer
had installed it during module install), it adds a validation constraint that flags
configuration entities created the wrong way, and it fixes a specific class of
already‑broken config — entities that are missing their UUIDs, which otherwise cause a
range of hard‑to‑diagnose problems.

The problem it addresses is familiar to anyone who deploys config: configuration created
outside the expected process — without proper dependencies, ownership, or a UUID — quietly
becomes a source of import failures and deployment surprises. Config Plus acts as a linting
and hygiene aid, surfacing those issues during development before they reach production.

This is **developer tooling**. It has no admin settings page, plays no runtime end‑user
access‑control role, and its main install helper is meant to be called from an
`hook_update_N()` in your own module's code. It works on Drupal `^9 || ^10 || ^11`. Note
that the release is an **alpha (1.0.0‑alpha3)** and the project is **not covered by Drupal's
security advisory policy**, so treat it as a development aid and test it on your workflow.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no configuration page** for this module — it has no settings form. You use it
from code, as described below.

## How to use it

- **Installing new config from a module.** When you add a new configuration file to a
  module and need existing sites to pick it up, call the installer service from a
  `hook_update_N()` in that module. For example:

  ```php
  \Drupal::service('config_plus.config_installer')
    ->installConfig('module', 'my_module', 'field.field.node.my_node_type.my_new_field');
  ```

  This installs the named configuration exactly as Drupal's own config installer would have
  during module installation.

- **Catching wrongly‑created config.** Once enabled, Config Plus's constraint watches for
  configuration entities that are created improperly (its check keys on a missing UUID). It
  does not *prevent* the save — the check runs afterwards — but it throws an exception and
  logs an error so the developer responsible is made aware they did something wrong.

- **Fixing missing UUIDs.** Config Plus corrects configuration entities that were installed
  without their UUIDs, heading off the assorted problems that missing UUIDs cause.

Because everything happens in code and behind the scenes, there is nothing to click through
after you enable the module — treat it as a config‑hygiene helper in your development and
deployment pipeline.
