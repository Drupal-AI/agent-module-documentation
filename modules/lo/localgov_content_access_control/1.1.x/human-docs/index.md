# LocalGov Content Access Control — manual setup guide

**LocalGov Content Access Control** (`localgov_content_access_control`) sets up
**section‑based editorial access control** for a **LocalGov Drupal** site (the
shared Drupal platform used by UK councils), so that specific editors can only
edit specific *sections* of the site. It is a **configuration‑only** module: it
ships ready‑made config and a role, but it contains no access logic of its own —
all the actual enforcement is done by the
[Workbench Access](https://www.drupal.org/project/workbench_access) module, which
it depends on and configures for you.

On install it provides:

- an **"Access Control" taxonomy vocabulary** — each term represents a site
  section;
- an **access‑control field** (`localgov_access_control`) added to the LocalGov
  Subsite Overview, Subsite Page, Service Landing Page, and Service Page content
  types;
- a **`site_section` Workbench Access scheme** (taxonomy‑based, using that
  vocabulary); and
- a new **"Devolved Editor"** role — intended for a subset of editors (perhaps
  people from outside your organisation) who may create only a little content
  (news, events, service pages) and edit existing subsite overview and service
  landing pages, but not create new ones.

The vocabulary is **hierarchical**: assign an editor to a parent term and they get
access to all of its child terms too. On install, the module grants the three
Workbench permissions (`use workbench access`, `access workbench`, and
`view workbench access information`) to every role **except** anonymous and
authenticated.

> **What it gates, precisely:** access is applied to the content types that carry
> the access‑control field, and it governs the create/edit/publish actions that
> Workbench Access controls, according to the section term(s) each editor is
> assigned. The scope of enforcement is exactly Workbench Access's — if you need to
> audit the underlying access checks, review the `workbench_access` module, which
> is where the grant logic runs. Note also that **uninstalling this module does
> not automatically remove the config it created** (the vocabulary, field, scheme,
> and role).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (Workbench and Workbench Access come with it).
2. [Configuration](configuration/index.md) — build your section taxonomy, make the
   field visible, and assign editors to sections.

## Where it lives in the admin menu

You assign editors to sections at **Configuration → Workflow → Workbench Access**
(`/admin/config/workflow/workbench_access`). The module ships one scheme called
**"Site Section"** that uses the Access Control vocabulary. The vocabulary itself
is managed at **Structure → Taxonomy → Access Control**.
