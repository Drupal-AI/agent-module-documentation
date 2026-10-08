# Site Studio core — manual setup guide

**Site Studio core** (`cohesion`) is the foundation of **Acquia Site Studio**
(formerly Cohesion / DX8) — a low-code, visual page-building system for Drupal.
Instead of hand-coding themes or assembling pages with Layout Builder, site
builders define **components**, **styles**, **templates**, and **website
settings** in the browser, and Site Studio compiles those definitions into CSS and
Twig. This base module supplies the plumbing: the Site Studio entity types, the API
layer that talks to Acquia's build service, the administration screens, and the
Drush commands used to import definitions and rebuild the generated assets.

On its own the base module does little that is visible — the actual features arrive
through its **submodules** (roughly seventeen of them). The important ones are
`cohesion_elements` (components), `cohesion_templates` (the Twig template layer),
`cohesion_custom_styles` and `cohesion_base_styles` (style management),
`cohesion_website_settings`, `cohesion_sync` (exporting and importing a Site
Studio package between environments), and `sitestudio_page_builder` (the in-page
drag-and-drop editor). There are also governance, data-transformer, Claro-theme,
and legacy CKEditor support submodules.

Site Studio is a **commercial Acquia product**. The module installs and enables
freely, but it **cannot compile styles or templates without a valid Acquia licence
/ API key** for the build service. So this module needs configuration before it is
useful: after installing, you enter your API credentials, then run an import and a
rebuild.

Two operational habits matter from day one. First, Site Studio's generated CSS and
Twig are **build artefacts, not configuration** — after any deployment that changes
Site Studio config you must run `drush cohesion:rebuild`, or your styles and
templates will be stale (this is the classic Site Studio failure mode). Second, on
a brand-new environment you run `drush cohesion:import` once to pull in the base
definitions.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the base
   module and the submodules you need, and pull in its dependencies.
2. [Configuration](configuration/index.md) — enter the Acquia API key, import the
   definitions, and run the post-deploy rebuild.

## Where it lives in the admin menu

Once enabled, Site Studio adds its own top-level **Site Studio** admin section
(under `/admin/cohesion`), where account settings, components, styles, templates,
and website settings live. Because the surface is large (hundreds of routes and a
substantial permission set), plan to grant the `administer cohesion` and related
permissions only to trusted site builders.
