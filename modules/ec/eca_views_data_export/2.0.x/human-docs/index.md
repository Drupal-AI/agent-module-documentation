# ECA Views data export — manual setup guide

**ECA Views data export** (`eca_views_data_export`) connects Drupal's no‑code
[ECA](https://www.drupal.org/project/eca) automation engine to the
[Views Data Export](https://www.drupal.org/project/views_data_export) module, so
an ECA model can trigger a data export of a View — CSV, XML and similar formats —
as part of an automated workflow. Instead of a person clicking "export", you can
have an export generated when an event fires.

Like other ECA integration modules, it has no settings form of its own. It
contributes ECA plugins that appear in the model editor once enabled; you build
the export behavior inside a model.

The exported data reflects exactly what the underlying View exposes, and it
respects that View's access. The module has no access‑control role of its own, so
the usual export caution applies: make sure the View you're exporting doesn't
include fields the recipient of the export shouldn't see. It depends on ECA and
supports Drupal 10.4 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside ECA and Views Data Export.

There is **no configuration page** for this module. It adds plugins you use
inside ECA models; see "How to use it" below.

## Where it lives in the admin menu

ECA Views data export adds no admin page of its own. You use it from the **ECA**
model editor (**Administration → Configuration → Workflow → ECA**), where its
export‑related plugins become available when you build or edit a model. The View
you export is managed under **Structure → Views**.

## How to use it

1. Make sure ECA and Views Data Export are installed, and that you have a View
   with a Data Export display to target.
2. Open the ECA model editor and create or edit a model.
3. Add an event to trigger the model, add any conditions you need, then use this
   module's plugin to run the export of your chosen View.
4. Save and enable the model. Double‑check the View doesn't expose fields the
   export recipient shouldn't see, and review the model as part of your normal
   configuration workflow.
