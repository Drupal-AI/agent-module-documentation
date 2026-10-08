# Drutopia Site — manual setup guide

**Drutopia Site** (`drutopia_site`) is a configuration-only base feature that
installs the shared site-wide building blocks the whole
[Drutopia](https://www.drupal.org/project/drutopia) distribution relies on.
Enable it and a site gains a consistent authoring baseline in one step: text
formats and their editors, a couple of reusable block content types, and a set of
editorial roles.

On install it creates the `basic_html`, `full_html` and `restricted_html` text
formats with matching **CKEditor 5** editors, two `block_content` bundles
(`basic`, which has a body field, and `slide`) with their form and view displays,
and — via its config actions — the editorial roles **contributor**, **editor**
and **manager**, along with tweaks to the authenticated/anonymous roles and
autosave settings. It pulls in a broad set of authoring dependencies (Admin
Toolbar with its Tools and Search submodules, Display Suite, Paragraphs, Entity
Reference Revisions, Menu Admin Per Menu, Role Delegation and Autosave Form) so
the whole editing experience is consistent across a fleet of Drutopia sites.

There is no custom code beyond a few update hooks (which, on older sites, swap the
obsolete admin-links-access filter for the Admin Toolbar equivalent and enable
the newer dependencies). Nothing is exposed to anonymous users beyond what the
imported roles and text-format permissions grant. It depends on
[`drutopia_core`](../../drutopia_core/2.0.x/human-docs/index.md), and higher-level
Drutopia content features (Article, Blog, Campaign, and so on) layer on top of
it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its authoring dependencies.

## Where it lives in the admin menu

There is no single settings form. You manage what it installs through the
standard core admin pages:

- **Editorial roles:** **People → Roles** (`/admin/people/roles`) and their
  permissions at **People → Permissions** (`/admin/people/permissions`).
- **Text formats and editors:** **Configuration → Content authoring → Text
  formats and editors** (`/admin/config/content/formats`).
- **Block content types:** **Structure → Block content → Block types**
  (`/admin/structure/block-content/types`).

## How to use it

Enable the module early on a Drutopia (or Drutopia-like) build, then manage the
resulting roles, block types and text formats through the admin UIs above. Assign
the contributor/editor/manager roles to your content team — Role Delegation lets
you delegate role assignment without granting full user administration — and
create reusable `slide` blocks for carousels or hero regions. Layer the Drutopia
content-type features on top for a fuller site.
