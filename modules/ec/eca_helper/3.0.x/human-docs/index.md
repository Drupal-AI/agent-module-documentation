# ECA Helper — manual setup guide

**ECA Helper** (`eca_helper`) extends the **[ECA](https://www.drupal.org/project/eca)**
(Event‑Condition‑Action) no‑code automation module with a big catalogue of extra
**actions** and a few extra **events**. If you build automation in the ECA modeller,
this module gives you ready‑made building blocks that would otherwise need a custom
module: making outbound HTTP requests, reading and setting server/request values,
setting response headers and cookies, injecting `<script>`/`<style>`/markup into the
page, reading and writing files, encoding/decoding JSON, writing to the key‑value
store, altering form and template (preprocess) variables, and more.

It ships around thirty `eca_helper_*` actions plus three custom events: a **Status
Messages** event (fires when Drupal renders status messages, so a model can read or
rewrite them), a **private file download** event (a model returns an access decision
that governs whether a `private://` file may be downloaded), and a generic
**preprocess** event (fires on every template preprocess so a model can alter any
template's variables). There is also a "Quick Action" plugin that lets a developer
register ad‑hoc PHP callables in a file and call them from a model without writing a
plugin class.

Everything is used **inside ECA models**, configured by administrators in the ECA
modeller — there is no settings form of its own, and it defines no permissions
(access is governed by ECA's own permissions). Because some of these actions are
powerful (outbound HTTP requests, file writes, running registered PHP callables),
treat the ability to edit ECA models as a trusted, admin‑level capability. An optional
submodule, **ECA Helper Workflow**, adds Content Moderation workflow‑state actions.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (with ECA) and
   enable the module (and the optional workflow submodule).

## Where it lives in the admin menu

ECA Helper has **no settings page and no permissions of its own**. Its actions and
events appear inside the **ECA** modeller when you build or edit an ECA model
(ECA is administered under **Configuration → Workflow → ECA**). Access is controlled
entirely by ECA's permissions.

## How to use it

1. Install and enable ECA, ECA Helper, and (for form actions) `eca_form` — see
   [Installation](installation/index.md).
2. In the ECA modeller, build or edit a model. When you add an **action** step, the
   ECA Helper actions appear in the list prefixed **ECA Helper: …** — for example
   *ECA Helper: HTTP request*, *ECA Helper: Set header*, *ECA Helper: Write file*,
   *ECA Helper: JSON encode/decode*.
3. To use the extra events, add one of the custom events to a model:
   - **Status Messages** — react when Drupal status messages are rendered; read or
     rewrite them.
   - **Private file download** — decide access for `private://` file downloads by
     returning an access result (Allowed lets the download proceed, Forbidden denies).
   - **Preprocess** — fires for every template preprocess so you can alter template
     variables from a model.
4. Most actions store their result in a token you name, so later steps can use it.

**Quick Action (developer extension point).** To call ad‑hoc PHP without writing a
plugin, create `DRUPAL_ROOT/sites/eca/EcaActions.php` defining a function
`ECAQuickActions()` that returns an array of `id => [label, callback]` (a function,
closure, or `service` + `method`). Then use the **ECA Helper: Quick Action** action,
pick your id, pass arguments as YAML, and capture the return value in a token. Note
this runs server‑side PHP chosen by an ECA administrator — a deliberate developer
extension point comparable to enabling a PHP snippet, so restrict who may edit models.
