# Datetime More Datelist Widget — manual setup guide

**Datetime More Datelist Widget** (`datetime_more`) extends Drupal core's
"Datelist" datetime widget so you can enter dates well outside the range core
allows and capture **seconds**, which core's Datelist leaves out.

Core's Datelist widget has three limitations this module removes. It restricts the
year selector to roughly 1900–2050; it only lets you type date and time parts as
select lists; and it has no seconds input. Datetime More adds a **"Datelist more"**
widget that lets you specify any minimum and maximum year from **0001 to 9999**,
choose whether each part renders as a *number field* or a *select list*, and
capture seconds. That makes it useful for scientific, historical, and astronomical
content — anything whose dates fall outside the everyday range core assumes.

It is a form-widget concern only: it changes how a datetime field is *entered*,
not how the value is stored (it reuses the existing core datetime field storage)
and not who can access it. There are no permissions and no routes.

The module works as soon as it is enabled — you switch a datetime field to the new
widget on its *Manage form display* screen. There is no central settings page; the
year bounds and number-vs-select choices are configured per field, in the widget's
settings on that screen.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module. After enabling it, choose the
"Datelist more" widget for a datetime field on its *Manage form display* tab, then
set the minimum and maximum year and the number-vs-select rendering in the widget
settings there.

## Where it lives in the admin menu

The module adds no admin page. You use it from **Structure → Content types →
*(your type)* → Manage form display**: change a datetime field's **Widget** to
**Datelist more**, then click the gear icon to set its year range and choose
whether the parts appear as number inputs or select lists.
