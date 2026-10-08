# Camunda BPMN for ECA — manual setup guide

**Camunda BPMN for ECA** (`camunda`) connects the Camunda BPMN modeller to the
[ECA](https://www.drupal.org/project/eca) (Event‑Condition‑Action) module. It lets
you model your ECA automations as BPMN diagrams in the standalone Camunda desktop
application and then import and export those diagrams to and from your Drupal site —
giving you a visual way to author ECA workflows instead of building them purely
inside Drupal's forms.

In other words, it is a bridge between the desktop Camunda Modeler and ECA's models:
you draw the process in Camunda, bring it into Drupal as an ECA model, and can send
it back out again to keep editing visually. It sits in the **ECA** package and
depends on the ECA module.

Treat this as an automation/developer feature. An imported model is executable
automation: once in ECA it runs with the site's privileges, exactly as any ECA model
does. The module has no access‑control role of its own, so only trusted users should
be allowed to author or import models — importing a BPMN diagram means importing
runnable logic.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (with ECA).

## How to use it

You'll work in two places. In the **Camunda desktop application** you draw the BPMN
diagram that represents your workflow. In **Drupal**, alongside the ECA module, you
import that diagram to create or update an ECA model, and export existing models back
out to continue editing them visually. Because the imported model becomes live ECA
automation, restrict who can import and author models to people you trust.
