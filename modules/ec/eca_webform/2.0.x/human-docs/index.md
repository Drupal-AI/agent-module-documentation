# ECA Webform — manual setup guide

**ECA Webform** (`eca_webform`) connects two popular modules so they can work
together without you writing any PHP. [Webform](https://www.drupal.org/project/webform)
builds forms; [ECA](https://www.drupal.org/project/eca) (Event–Condition–Action) is a
no‑code automation engine where you draw workflows — "when *this* happens, check
*that*, then do *these things*." ECA Webform makes Webform's many internal hooks
available as ECA **events**, and adds a few ECA **actions** for reading and writing
submission data. The result: you can automate Webform behavior from an ECA model
instead of building a custom Webform handler in code.

On the events side, the module turns 25 of Webform's alter and access hooks into ECA
events you can start a model from — for example "a submission form is being built,"
"access to a submission is being checked," "an element's options are being
assembled," or "submissions are about to be purged." Each event hands your model the
relevant data as tokens (like `[webform:element]` or `[webform:operation]`) so your
workflow can read and react to it.

On the actions side, it adds four building blocks you can drop into a model: two that
read and write a value in a webform submission, and two that read and write a
webform's third‑party settings. Because these are ordinary ECA actions, you can chain
them with everything else ECA offers — send an email, save an entity, call an HTTP
service — all triggered by a form event.

There is **no settings page** for this module. Everything is done inside ECA models,
which you build in the ECA modeller UI (or import as configuration). This is a
developer/site‑builder tool: to get value from it you should already be comfortable
with both Webform and ECA.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside ECA and Webform.

The module has no configuration form of its own, so there is no configuration page —
you use it entirely from within ECA models, as described below.

## Where it lives in the admin menu

ECA Webform adds **no admin pages, no settings form, and no permissions** of its own.
You work with it inside the ECA modeller (provided by the ECA module, typically under
**Configuration → Workflow → ECA**), where its events and actions appear in the lists
of things you can add to a model.

## How to use it

The workflow always happens inside an ECA model:

1. **Start from a Webform event.** When you add the starting event to a model, pick
   one of the `webform:*` events — for instance `webform:submission_form_alter` (a
   submission form is being built) or `webform:submission_access` (access to a
   submission is being decided). The event feeds your model tokens under the
   `webform` namespace describing what is happening.
2. **Add conditions and actions.** Branch on the tokens (for example, act only when
   `[webform:operation]` is `update`), then attach actions. To read a submitted
   value into a token, use **Get submission data** (`eca_webform_submission_get_data`)
   with the element's machine name. To change a submitted value mid‑workflow, use
   **Set submission data** (`eca_webform_submission_set_data`). To read or write a
   webform's stored third‑party settings, use the matching *get/set third‑party
   setting* actions.
3. **Chain onward.** From there you can invoke any other ECA action — send a
   notification, create a related entity, compute a reference number and write it
   back into the submission, and so on.

A few of the events (access rules, element input masks, and contextual help) are
"two‑way": your model can *contribute* values back, letting you declaratively add,
say, custom webform access rules from a model rather than in code.

Because a model is just exportable configuration, all of this Webform automation
lives in your site config and deploys like any other config change — no custom module
required.
