# Design system gov.cz — manual setup guide

**Design system gov.cz** (`gov_cz`) brings the official Czech government design
system (gov.cz) to Drupal as **Single Directory Components** (SDC). It packages the
design system's components — built with Twig — together with the CSS styles and
fonts, so you can build Czech public-sector sites that follow the national visual
standard.

The module ships the components and loads the libraries that carry the gov.cz
styles. It also includes some basic npm scripts that fetch the various design-system
parts from their NPM repository and tidy up the files. As soon as you enable it, the
front end picks up the gov.cz fonts and colours — but to get the full benefit you
need to integrate the SDC components into your own theme.

This is a theming / component-library module: it provides components and styling and
has no content type, settings form, or access-control role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** — the module has no settings form. You work with
it entirely from your theme, described in "How to use it" below.

## How to use it

After enabling the module you should already see the design system's fonts and
colours applied on the front end. For full use, integrate the provided SDC
components into your theme's templates and markup. If you want a jumpstart, look at
the **CSGOV** installation profile, which ships a custom theme and configuration
that lean heavily on this module.
