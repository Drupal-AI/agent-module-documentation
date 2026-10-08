# FormAssembly — manual setup guide

**FormAssembly** (`formassembly`) integrates your Drupal site with the
[FormAssembly](https://www.drupal.org/project/formassembly) hosted form service.
FormAssembly is a form platform used mainly by Salesforce‑centred organisations,
where the form's real value is its connection to CRM objects. This module lets
you render those hosted forms **natively inside Drupal pages** instead of dropping
in an iframe — so site styling, accessibility, and analytics all keep working.

Each remote form is represented by an `fa_form` **configuration entity**. The
module fetches the form's markup over the FormAssembly API and re‑parses it (using
Symfony's DOM Crawler and CSS Selector components) so it renders as part of the
page rather than in an isolated frame. Forms can either be embedded in Drupal
content via an entity‑reference field or displayed on their own path, and — if the
Token module is enabled — default field values can be pre‑filled dynamically from
Drupal data. On submission, the visitor sees a thank‑you message or is redirected;
when embedded, the form is replaced in place by the thank‑you message.

Authentication to FormAssembly uses **OAuth**, handled through a two‑step admin
authorisation flow and the `fathershawn/oauth2-formassembly` library. Because
those OAuth tokens and credentials are secrets, this guide shows how to keep them
out of exported configuration using an environment variable and (optionally) the
Key module.

A security note straight from the module's own README: this integration trusts
the FormAssembly service and injects its HTML, CSS, and JavaScript as native
elements in your site. Stay informed about FormAssembly's own security posture
while you use it, and note that an upstream change to the remote markup can break
rendering — so pin the module version and re‑test after upgrades.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its PHP
   dependencies with Composer, and enable it.
2. [Configuration](configuration/index.md) — store your OAuth credentials safely,
   run the authorisation flow, and create form entities.

## Where it lives in the admin menu

FormAssembly's form entities live under **Structure → FormAssembly forms**
(`/admin/structure/fa_form`). The OAuth authorisation flow is at
`/admin/structure/fa_form/settings/authorize` and
`/admin/structure/fa_form/settings/code`, both gated by the **Administer
FormAssembly form entities** permission (which is marked as restricted access).
Four permissions in total separate administering, editing, listing, and viewing
the form entities. See [Configuration](configuration/index.md).
