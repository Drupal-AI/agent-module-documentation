# Tapis App Webform — manual setup guide

**Tapis App Webform** (`tapis_app_webform`) connects Drupal's Webform module to
TAPIS apps, so that a form submission can supply the inputs and command-line
arguments for a TAPIS job. It is the piece that turns a defined TAPIS app into
something a user can actually fill in and launch from a science gateway.

It works automatically: whenever a TAPIS app is created with the input type
**Form**, the module creates a new Webform with the same name as the app. You then
add Webform elements to that form to represent the app's inputs. It depends on the
**Webform** and **Webform UI** modules and registers its own permissions.

There is no central settings form — the configuration happens per app, on the
Webform you build for it. One data-handling note: form submissions feed TAPIS
app and job parameters and may be sent on to the TAPIS API (egress, via the other
TAPIS modules), so handle submission data appropriately for the kind of research
inputs your users enter.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and its Webform dependencies.

## How to use it

Once installed, the workflow is:

1. Create a TAPIS app (via **TAPIS Apps**) with the input type **Form**. A Webform
   with the same name as the app is created for you.
2. Edit that Webform and add elements to represent the app's inputs. Use any of
   the Webform elements that have **(OSP)** in their name — these are the ones this
   module maps to command-line arguments.
3. For each OSP element, set its **command-line prefix/suffix** settings
   correctly. The **order** of the elements on the form — top to bottom, left to
   right — determines the order of the corresponding command-line arguments.
4. To conditionally skip a parameter, add a hidden OSP checkbox element with the
   key `_arg_ignore`. When that checkbox is checked, its element is ignored; when
   unchecked, the element is included.
5. When the app and its Webform are ready, go to the app's page and click the
   **Launch** tab to submit a job using the form.
