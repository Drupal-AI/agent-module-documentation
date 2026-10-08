# ECA Entity Print — manual setup guide

**ECA Entity Print** (`eca_entity_print`) adds ECA **action plugins** that print a
chosen entity or a View to a PDF (or other document format) and save the result as
a Drupal **file entity**. It is the bridge between
[ECA](https://www.drupal.org/project/eca) (Event-Condition-Action) automation and
the [Entity Print](https://www.drupal.org/project/entity_print) module, so
document generation can happen automatically as a step inside an ECA workflow — for
example, generating an invoice PDF the moment an order is marked complete.

The generated document reflects the **rendered** entity or View — that is, the
content the render context can access at the time the action runs. The module has
no access-control role of its own; it simply renders and saves. It is an
automation/content feature that you drive entirely from ECA models.

There is no settings form to fill in — you configure the print action inside an
ECA model. It depends on the ECA base module (`eca`), and you will also need the
**Entity Print** module installed and configured (including a PDF engine such as
Dompdf or wkhtmltopdf) for the actual rendering. ECA modelling tools worth knowing
about are BPMN.iO (visual diagram modeller), Camunda (desktop modeller), and the
ECA Classic Modeller (Drupal form-based).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside ECA and Entity Print.

There is **no configuration page** for this module — it has no settings form. You
configure its print actions inside the ECA modeller, described in "How to use it"
below.

## Where it lives in the admin menu

ECA Entity Print adds no admin page of its own. You build models in the ECA
modeller at **Configuration → Workflow → ECA** (`/admin/config/workflow/eca`).
Entity Print's own settings (default PDF engine and so on) live at **Configuration
→ Content authoring → Entity Print** (`/admin/config/content/entityprint`).

## How to use it

1. Install and configure **Entity Print** first, including a working PDF engine,
   so document rendering succeeds outside ECA.
2. In the ECA modeller at **Configuration → Workflow → ECA**, build a model that
   listens for the event you want (for example an order reaching a completed
   state).
3. Add the ECA Entity Print action to the model and configure which entity or View
   to print, the output format, and where the resulting file entity should be
   saved.
4. Continue the model with whatever should happen next — attach the file to an
   email, reference it on the entity, and so on.
