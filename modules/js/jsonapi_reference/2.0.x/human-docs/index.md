# JSON:API Reference — manual setup guide

**JSON:API Reference** (`jsonapi_reference`) provides a field type — a *Typed
Resource Object* — that works much like an entity-reference field, except it does
**not** refer to an entity on the same Drupal site. Instead it points at a resource
object exposed by an **external** JSON:API endpoint. That makes it a natural fit for
syndication: when you push content from one system to another, you can record on the
source system a reference to the corresponding record on the destination system, and
vice versa.

For example, you might add a Typed Resource Object field to the user entity on the
source site that refers to the matching user on the destination site, and add
similar fields on the content types you syndicate so you can track the relationship
to the content you create elsewhere. The field ships with an **autocomplete widget**
that queries the remote system as you type and suggests matches. Because different
resource object types autocomplete against different attributes, you configure the
attribute to match against in the widget settings.

A few caveats worth knowing up front (from the module's own notes):

- All fields are assumed to come from the **same remote system**.
- Authentication to the remote system is assumed to be **HTTP basic
  authentication**.
- The module has been built against Drupal-to-Drupal JSON:API and relies on some
  Drupal-isms, so a non-Drupal remote system probably will not work.
- It provides **no field formatters**, so by default a reference is displayed as the
  GUID of the remote resource object (as plain text).

**Security considerations.** The remote endpoint is configured by an administrator
— it is not supplied by end users — so this is not an open SSRF surface. Even so:
store any credentials for the endpoint as **secrets** (never hard-code or commit
them), make sure the endpoint is reached over **TLS**, treat the fetched data as
**external input** and escape it on output, and confirm the configured endpoints are
trusted.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the module's configuration form and
   the per-field widget settings.

## Where it lives in the admin menu

The module provides a configuration form (`jsonapi_reference.json_api_reference_config_form`)
where you set up the JSON:API source(s), and per-field widget settings on your
field's **Manage form display**. It also provides its own permissions, granted at
**People → Permissions** (`/admin/people/permissions`).

> **Want a quick evaluation setup?** There is a Drupal Recipe,
> [`test_jar`](https://www.drupal.org/project/test_jar), that configures a site for
> easy manual testing of JSON:API Reference. It is for evaluation only — do not use
> it in production.
