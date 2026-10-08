# Clientside Validation — manual setup guide

**Clientside Validation** (`clientside_validation`) adds **in‑browser** validation
to Drupal forms, so users see errors (like "this field is required" or "enter a
valid email") *before* they submit — no round‑trip to the server. It reduces
failed submissions and makes long forms much friendlier to fill in.

The module comes in two parts. The **base module** (`clientside_validation`) does
the wiring: it walks every form's elements and decorates them with HTML5 and
`data-rule-*` / `data-msg-*` validation attributes based on their type (email,
url) and properties (required, pattern, min, max, maxlength, step, and so on). On
its own the base module changes nothing you can see — it only writes attributes.
The **engine submodule** (`clientside_validation_jquery`) is what actually runs
the validation: it loads the jQuery Validate library and turns those attributes
into live, before‑submit checks with inline error messages. **You need both
modules enabled** for anything visible to happen.

Because the base module reads standard Drupal form properties, most validation
"just works" once the engine is on — required fields, email/url types, numeric
min/max/step, and maxlength are all handled by the eight validators it ships. The
jQuery submodule adds pattern and "must match" (equal‑to) rules. Developers can
add their own rules through the `CvValidator` plugin type, or skip validation for
specific forms with a hook.

Note: the base module itself has **no settings form** — its only real
configuration is the **jQuery engine's** settings page (CDN vs local library,
AJAX‑form validation, HTML5 behavior). The [Configuration](configuration/index.md)
page covers it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable both the base module and the jQuery engine submodule.
2. [Configuration](configuration/index.md) — the jQuery engine's settings, plus
   how per‑element messages work.

## Where it lives in the admin menu

The base module adds **no menu item**. Once you enable the **jQuery engine**
submodule, its settings form lives at *Configuration → User interface → Clientside
Validation jQuery settings*
(`/admin/config/user-interface/clientside-validation-jquery-settings`), gated by
the **Administer site configuration** permission.

## How to use it

1. Enable both `clientside_validation` and `clientside_validation_jquery` (see
   [Installation](installation/index.md)).
2. That's usually all — existing forms with required fields, email/url fields, or
   numeric limits now validate in the browser.
3. Optionally visit the jQuery settings form to choose a local library or CDN and
   tune AJAX / HTML5 behavior. Developers can customize per‑element error text via
   render‑array keys like `#required_error` and `#pattern_error`.
