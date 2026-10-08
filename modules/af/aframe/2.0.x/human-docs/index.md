# A-Frame Integration — manual setup guide

**A-Frame Integration** (`aframe`) brings the
[A-Frame](https://aframe.io/) WebVR/WebXR framework into Drupal as fields. It
provides field widgets so editors can enter a 3D/VR scene on a piece of content,
and field formatters so that scene renders as an immersive, interactive
experience on the front end — models, entities, cameras, and so on — without
anyone hand-writing the JavaScript needed to boot an A-Frame scene.

In short, it lets a site publish 3D and virtual-reality content the same way it
publishes any other field value: add the field, fill it in, and let the formatter
handle the display. It is a media/content-display feature and has no
access-control role of its own.

**A note on trust.** The scene markup and asset URLs an editor enters are treated
as author-controlled input, and the rendered output is escaped/sanitised in the
normal Drupal way. As with any field that accepts markup, only let trusted roles
author scenes.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

> **Version note:** this is an alpha release (2.0.0-alpha1) — test it before
> relying on it in production.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

A-Frame Integration has no central settings page; you work with it as fields on
your content types:

1. Go to a content type's **Manage fields**
   (**Structure → Content types → *your type* → Manage fields**) and add a field
   of the A-Frame type provided by the module.
2. Under **Manage form display**, assign the module's A-Frame **widget** so
   editors can enter the scene.
3. Under **Manage display**, assign the module's A-Frame **formatter** so the
   scene renders on the front end.
4. Create or edit content of that type, enter the 3D/VR scene, and save. Visitors
   see the interactive A-Frame experience where the field is displayed.
