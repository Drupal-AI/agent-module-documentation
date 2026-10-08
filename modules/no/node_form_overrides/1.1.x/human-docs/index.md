# Node Form Overrides — manual setup guide

**Node Form Overrides** (`node_form_overrides`) lets you rewrite the page titles
and submit‑button labels that Drupal shows on node add, edit, and delete forms —
either as a site‑wide default or per content type — without writing a line of
`hook_form_alter` code. Instead of a generic "Save" button and an "Edit *Article*"
page title, you can present editors with wording that matches each content type's
purpose: "Publish event", "Add a new team member", or a friendlier "Are you sure
you want to remove this press release?" delete prompt.

The problem it solves is a familiar one for site builders: tweaking node‑form
titles and button text is a common request, and doing it by hand means a custom
module with a `hook_form_alter` per content type. This module moves those tweaks
into configuration. You set global defaults once, and any content type can opt out
of the defaults and supply its own values. The shipped defaults already use tokens
such as `[node:content-type:name]`, and if you enable the optional **Token**
module the values are run through the token system so you can build dynamic
titles and labels.

It depends only on core's **Node** module (Token is optional but recommended).
There is nothing to configure for it to be *installed*, but it does nothing
visible until you set at least one override, so plan to visit the settings form
after enabling it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the global settings form and the
   per‑content‑type "Label Overrides" tab, field by field.

## Where it lives in the admin menu

The global settings form sits at **Configuration → Content authoring → Node Form
Overrides** (`/admin/config/content/node-form-overrides`). Per‑content‑type
overrides live on each content type's own edit form, under a new **Label
Overrides** tab (**Structure → Content types → *(your type)* → Edit**). Both are
gated by the **Administer content types** permission.
