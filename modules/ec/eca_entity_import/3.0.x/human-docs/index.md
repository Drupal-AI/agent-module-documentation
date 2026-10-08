# ECA Entity Import — manual setup guide

**ECA Entity Import** (`eca_entity_import`) provides an ECA **migrate process
plugin** for the [Entity Import](https://www.drupal.org/project/entity_import)
module, so [ECA](https://www.drupal.org/project/eca) (Event-Condition-Action)
automation can drive and transform entity imports as they run through Drupal's
core Migrate pipeline. In other words, it connects no-code ECA automation to your
import pipelines: as rows are imported, an ECA model can react and transform the
data.

Setup is deliberately minimal — the module advertises "zero configuration." Once
the ECA process plugin is active, a token becomes available inside your ECA
models: **`row:source:importer_id`**, which contains the ID of the current entity
importer. That lets an ECA model know which importer is running and branch
accordingly.

Because imports process source data with **migration privileges**, this is a
developer/automation feature meant to be run by trusted operators: validate your
sources and run imports as a trusted operator. The module has no access-control
role of its own. It depends on core **Migrate**, the **Entity Import** module, and
**ECA Migrate** (`eca_migrate`, `>=3.0.3`), and this 3.0.x branch targets Drupal
11.2+.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Migrate, Entity Import, and ECA Migrate.

There is **no configuration page** for this module — it has no settings form. You
use its migrate process plugin and the `row:source:importer_id` token inside the
ECA modeller and your Entity Import configuration, described in "How to use it"
below.

## Where it lives in the admin menu

ECA Entity Import adds no admin page of its own. Importers are configured on the
Entity Import side (under **Configuration → Development → Entity Importer**, path
`/admin/config/development/entity_importer` on a typical setup), and the ECA
models that react to imports are built in the ECA modeller at **Configuration →
Workflow → ECA** (`/admin/config/workflow/eca`).

## How to use it

1. Set up an importer with the **Entity Import** module as you normally would.
2. In the ECA modeller at **Configuration → Workflow → ECA**, build a model that
   reacts to the import (using ECA Migrate's events).
3. Inside that model, use the **`row:source:importer_id`** token to identify which
   importer is running, and branch or transform accordingly.

Because imports run with migration privileges, keep this to trusted operators and
validate the source data you import.
