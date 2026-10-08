# ECA Drush Integration — manual setup guide

**ECA Drush Integration** (`eca_drush`) connects
[ECA](https://www.drupal.org/project/eca) (Event-Condition-Action) with **Drush**,
Drupal's command-line tool. It adds an ECA **action plugin that invokes a Drush
command**, so an ECA model can shell out to Drush as one of its steps — and, more
broadly, it lets ECA automation participate in a command-line context. If you
already drive tasks from the CLI or from cron via Drush, this lets those tasks and
your ECA models meet in the middle.

ECA models are powerful: they can create, modify, and delete entities, send email,
and run arbitrary actions. This module extends *where* those models can run
(the Drush/CLI context), which itself already requires shell access to the server.
It does **not** broaden who is allowed to author ECA models — but that is exactly
the trust boundary to keep in mind. Authoring an ECA model is a code-equivalent,
administrative capability, so keep ECA-model authoring restricted to trusted
administrators.

The module has no settings form of its own — you use its Drush action from inside
the ECA modeller. Its only dependency is the ECA base module (`eca`). Note this is
an early release (1.0.x, alpha) and is **not covered by Drupal's security advisory
policy**, so weigh that before using it on a production site.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside ECA.

There is **no configuration page** for this module — it has no settings form. You
use the Drush action it adds from within the ECA modeller, described in "How to use
it" below.

## Where it lives in the admin menu

ECA Drush Integration adds no admin page of its own. You work with it inside the
ECA modeller at **Configuration → Workflow → ECA** (`/admin/config/workflow/eca`).

## How to use it

1. Open or create an ECA model at **Configuration → Workflow → ECA**.
2. Add an **action** to your model and choose the Drush command action this module
   provides.
3. Configure the command and its arguments in the action's settings.
4. Wire the action into your model's flow so it runs when the event and conditions
   you chose are met.

Because a Drush command can do anything Drush can do, treat these models as
privileged and restrict who may author them.
