# Paragraphs Collection — manual setup guide

**Paragraphs Collection** (`paragraphs_collection`) is a collection of **behaviour
plugins, style plugins, and grid layouts** for the
[Paragraphs](https://www.drupal.org/project/paragraphs) module. Paragraphs itself
gives editors component‑assembled pages but provides mostly the *mechanism*; this
module adds ready‑made *plugins* that change how any paragraph behaves — for
example a **lockable** state that protects a section from editing, **style**
plugins that apply preset presentation classes, **background** options,
**visibility per language**, and **grid** layouts. It also registers report pages
that list the available layouts and styles.

Be clear‑eyed about what this is. The module's own description calls it "a
collection of **EXPERIMENTS**," and the version documented here
(`8.x-1.0-alpha12`, on Drupal `^10.2 || ^11`) is an **alpha**. It comes from the
Thunder distribution's ecosystem and is capable but opinionated and closely tied to
how Thunder builds pages. Two consequences matter: plugins here may change shape
between releases, and **behaviour‑plugin settings are stored on the paragraph
entities themselves**, so a plugin that changes or disappears leaves data behind on
your content. The realistic approach for a new project is to read it for the ideas
and adopt individual pieces knowingly — not to base a client's whole page‑building
strategy on an alpha that names itself an experiment, unless someone is prepared to
own the churn.

Note also that this module is **not covered by Drupal's security advisory policy**.

It requires Paragraphs plus core's Image and Link modules, and defines an
`administer lockable paragraph` permission along with further per‑plugin
permissions.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and optionally add the demo/test submodules.

There is **no single central settings form** for this module. Its features are
plugins you enable per paragraph type (on the paragraph type's **Behaviors**), and
it exposes report pages that list what's available — both covered in "How to use
it" below.

## Where it lives in the admin menu

- The plugins are enabled per paragraph type at **Structure → Paragraph types →
  *(type)* → Edit**, in the **Behaviors** section.
- Report pages list what the module provides, behind the *administer paragraphs
  types* permission:
  - Layouts: `/admin/reports/paragraphs_collection/layouts`
  - Styles: `/admin/reports/paragraphs_collection/styles`
- Permissions (including *administer lockable paragraph* and the per‑plugin
  permissions) are granted at **People → Permissions**
  (`/admin/people/permissions`).

## How to use it

1. Enable the module (see [Installation](installation/index.md)). Because it is a
   collection, it installs its example paragraph types so the plugins have
   something to work with.
2. Grant the relevant permissions at **People → Permissions** — at minimum decide
   who may *administer lockable paragraph* and any other per‑plugin permissions you
   plan to use.
3. Edit a paragraph type at **Structure → Paragraph types → *(type)* → Edit** and
   enable the behaviour and style plugins you want (lockable, style selection,
   background, per‑language visibility, grid layout, and so on) in the **Behaviors**
   section.
4. Check the layout and style report pages under
   `/admin/reports/paragraphs_collection/` to see what is available before building
   content.

> **Before you rely on it:** remember behaviour‑plugin settings live on the
> paragraph content itself. If you later remove or change a plugin, plan for the
> leftover data on existing paragraphs. Given the alpha, experimental status,
> adopt individual features deliberately.
