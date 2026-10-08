# Acquia CMS Site Studio — manual setup guide

**Acquia CMS Site Studio** (`acquia_cms_site_studio`) is the installation-code
**glue** that wires **Acquia Site Studio** — the Cohesion low-code, drag-and-drop
page builder — into an Acquia CMS site. It installs the Site Studio configuration
and connects the Cohesion modules so editors can build layouts visually.

It is part of the **Acquia CMS** family and depends on `acquia_cms_common` plus
the Cohesion/Site Studio modules (base styles, custom styles, elements, style
helpers, sync, website settings, and the page builder). Crucially, Site Studio is
a **proprietary Acquia product**: it requires the Site Studio platform and a valid
license/API key to function. Without that, the Cohesion dependencies are not
available and the module cannot do its job.

Like the rest of the family this is distribution configuration and glue, designed
to be adopted with the other `acquia_cms_*` modules. It is exactly right on an
Acquia CMS site licensed for Site Studio and simply won't work on a site that
lacks the Site Studio platform.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and the Cohesion/Site Studio dependencies.
2. [Configuration](configuration/index.md) — enter your Site Studio API key and
   import the packages so the builder is ready.

## Where it lives in the admin menu

Once Site Studio is enabled and licensed, its tooling appears under its own admin
section:

- **Site Studio** (the Cohesion admin area) — configuration, account settings
  (API key), styles, components, and templates.
- The **page builder** attaches to content editing so editors can lay out pages
  visually.

## How to use it

After the API key is entered and the initial packages are imported (see
[Configuration](configuration/index.md)), editors use the Site Studio page builder
to compose pages from components and styled elements, without writing code. Site
builders manage the component library, styles, and templates through the Site
Studio admin section.
