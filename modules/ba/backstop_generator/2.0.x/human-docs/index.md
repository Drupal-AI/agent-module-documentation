# Backstop Generator — manual setup guide

**Backstop Generator** (`backstop_generator`) builds the `backstop.json`
configuration file that [BackstopJS](https://github.com/garris/BackstopJS) uses
for visual-regression testing. BackstopJS takes screenshots of your pages at
different screen widths and compares them against a saved reference set, so you
catch unintended visual changes — a broken layout, a shifted element, a colour
that changed — before your users do. Writing that config by hand is tedious;
this module generates it from your site.

It builds the scenario and viewport parts of the config from the site's URLs and
its configured breakpoints, so the screenshots are taken at the widths your theme
actually targets. It depends on core's **Breakpoint** module and provides its own
permission, so you can restrict the generator to developers and administrators.

This is a developer/testing tool: it reads your site structure to produce a
config file and has no content-facing role beyond its permission. It runs on
Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — set up your scenarios and generate
   the `backstop.json` file.

## Where it lives in the admin menu

The generator's settings form is provided at the
`backstop_generator.settings_form` route, under the site's Configuration area.
Gate access to it with the module's permission so only developers and
administrators can generate the file.
