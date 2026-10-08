# ECA — manual setup guide

**ECA** (`eca`) — short for **Events – Conditions – Actions** — is a visual,
no‑code automation and orchestration framework for Drupal. You build *models*:
workflows that react to an **event**, check some **conditions**, and then run one
or more **actions** — all without writing custom code. It is the modern successor
to the Rules module, and it can replace a lot of bespoke "glue" code with
transparent, deployable workflows.

**ECA Core** (this module) is the processing engine. It listens to Drupal events,
matches them against the models you have built, evaluates the conditions, and
executes the actions. Events and conditions are plugins (ECA defines its own plugin
types for them), and ECA decorates core's action plugin manager so every core and
contrib action is available too. Models are stored as `eca` **configuration
entities**, so they import, export, and deploy through Drupal's standard config
management or Drush.

Two important things follow from that design. First, **ECA Core ships no automation
of its own** — the actual events, conditions, and actions come from its many
submodules (content, form, user, views, workflow, queue, cache, and more), so you
enable the ones for the subsystems you want to automate. Second, **you build models
in a visual editor**, which is provided by the **ECA UI** submodule together with a
separate *modeler* module such as `bpmn_io`. It integrates with Drupal tokens for
passing data between steps and supports scheduled, cron‑based triggers.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (note the PHP and
   modeler requirements), enable ECA Core, and choose submodules.
2. [Configuration](configuration/index.md) — enabling the UI and a modeler, where
   models live, and how to build one.

## Where it lives in the admin menu

ECA Core has **no page of its own**. Once you enable the **ECA UI** submodule (plus
a modeler), models are managed at **Configuration → Workflow → ECA**
(`/admin/config/workflow/eca`), which is also where the UI's settings form lives.

## How to use it

Because ECA Core is inert on its own, a working setup means turning on the right
pieces:

1. **Enable ECA UI and a modeler** — `eca_ui` for the management screen, and a
   modeler such as `bpmn_io` for the drag‑and‑drop editor. See
   [Installation](installation/index.md).
2. **Enable the capability submodules** for what you want to automate — for
   example `eca_content` for content‑entity events, `eca_form` for form handling,
   `eca_user` for user events. Each `eca_*` submodule adds its subsystem's events,
   conditions, and actions (see [Configuration](configuration/index.md)).
3. **Build a model** at `/admin/config/workflow/eca`: pick a starting event, add
   conditions, wire up actions, and save.
4. **Rebuild the subscribers** so new triggers take effect —
   `drush eca:subscriber:rebuild` (this also happens on a cache rebuild).

Models are configuration, so once built you export them and deploy across
environments like any other config. Developers can extend ECA with custom event,
condition, or action plugins.
