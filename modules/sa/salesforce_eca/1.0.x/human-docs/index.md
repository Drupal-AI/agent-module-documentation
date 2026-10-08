# Salesforce ECA — manual setup guide

**Salesforce ECA** (`salesforce_eca`) bridges the Salesforce Suite and Drupal's
**Event-Condition-Action (ECA)** system, so you can build automated workflows
around Salesforce synchronization visually, without writing custom code. It
exposes Salesforce push and pull sync events to ECA's workflow builder, adds
actions for running SOQL queries and triggering immediate push/pull operations,
and makes Salesforce data available as tokens you can use anywhere in an ECA model.

The problem it solves is the glue code you would otherwise write by hand: notifying
an administrator when a Salesforce sync fails, updating related Drupal content when
Salesforce data changes, querying Salesforce on demand for a dynamic workflow, or
adding custom business logic around synchronization. With Salesforce ECA, those
become ECA models you assemble in the visual interface.

The module does not have a settings form of its own — its "configuration" is the
ECA models you build. It depends on the **Salesforce Suite**
(`salesforce` and `salesforce_mapping` at minimum) and on **ECA** (`eca`). Two
further Salesforce Suite modules are optional but unlock more: **Salesforce Push**
is needed for the push events and push action, and **Salesforce Pull** for the pull
events and pull action — the module handles their absence gracefully, so push/pull
events only appear when the matching module is enabled. There are no submodules of
its own. Salesforce credentials are always managed by the Salesforce Suite, not by
this module.

> **This is an alpha release.** Core functionality has been tested, but expect rough
> edges and check the issue queue before relying on it in production.

This guide is written for a **human**. If you are an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — Composer, the Salesforce Suite and ECA
   dependencies, and the optional push/pull modules.

## How to use it

Salesforce ECA has no configuration page — you work entirely inside ECA. After
enabling it (and configuring the Salesforce Suite's connection separately):

1. Go to **Configuration → Workflow → ECA**
   (`/admin/config/workflow/eca`) and create a new model.
2. When adding a trigger, look for events prefixed **"Salesforce:"** — there are
   ten of them (push success/fail, the various pull stages, and so on). Push and
   pull events only appear if the respective Salesforce module is enabled.
3. Add the module's actions to run a SOQL query or trigger a push/pull operation,
   and use the token browser to pull Salesforce data into any ECA action.
4. Check the ECA log at `/admin/config/workflow/eca/log` when debugging a workflow.

A practical tip from the module's docs: test your SOQL queries in the Salesforce
Developer Console first, then paste the working query into your ECA action.
