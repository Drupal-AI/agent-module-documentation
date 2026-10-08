# Bootstrap Components — manual setup guide

**Bootstrap Components** (`bootstrap_components`) provides lightweight Bootstrap
5 **Single Directory Components (SDC)** — reusable front‑end components such as
cards, buttons, and accordions, built with Bootstrap 5 markup as SDC. Once
enabled, these components are available to use in your Twig templates and in
Layout Builder. It lives in the *User Interface* package.

It is a theming/front‑end feature: the components are theme/authoring
constructs, and it has no content or access role. There is no admin settings
page — you use the components directly in your theme and layouts.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There is no settings form of its own. The components it provides become available
to your templates and to **Layout Builder** — there is no configuration screen to
visit.

## How to use it

1. Enable the module so its Single Directory Components are registered.
2. Use the components (cards, buttons, accordions, and the like) where you build
   your UI — reference them from your theme's Twig templates, or drop them in via
   Layout Builder.
3. Because they are built with Bootstrap 5 markup, make sure your theme provides
   the Bootstrap 5 styling/behavior the components expect.
