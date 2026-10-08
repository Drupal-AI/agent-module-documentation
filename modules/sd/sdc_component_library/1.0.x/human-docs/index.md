# SDC Component Library — manual setup guide

**SDC - Component library** (`sdc_component_library`) gives your site a single page
that previews its **Single Directory Components (SDC)**, so designers and developers
can see the whole component set in one place without installing Storybook.

Single Directory Components are Drupal core's standard way to package a component —
its Twig template, CSS, JavaScript, and a schema describing its props and slots, all
in one folder. What core does not give you is a way to *look* at them: components are
only visible where they happen to be used, so a design system built from SDC has no
gallery. The usual answer is Storybook, which brings a Node toolchain and a parallel
rendering environment, with the ongoing risk that the story drifts from the real
component. This module takes the lighter route: it automatically reads all the SDCs
in your theme and renders them **through Drupal itself**, so what you see is exactly
what the site renders. Components that include a `.story.twig` file are previewed
with dummy data, and there is optional integration with a WCAG checker for
accessibility validation right inside the preview.

The module works with very little setup — once enabled it lists your components and
you can view them; to get the full rendered previews, your components need a
`.story.twig` file. There is a small settings form that controls which components
appear. Access to the gallery is gated by a single permission,
**`access sdc component library`**, which is deliberately marked as a restricted
permission — and that is the right call, because a component gallery enumerates your
site's front-end building blocks and renders arbitrary components, which is useful
reconnaissance you would not want exposed to the public. Grant it to developers and
designers only. The module requires core's SDC support and targets Drupal 10.3+ and
11.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form and the gallery
   permission.

## Where it lives in the admin menu

The settings form sits at **Configuration → System → SDC Component Library**
(`/admin/config/system/sdc-component-library`). The component preview itself is
served at `/sdc-component-library` and is protected by the
`access sdc component library` permission.
