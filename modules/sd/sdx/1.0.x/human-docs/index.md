# SDX — manual setup guide

**SDX** (`sdx`) extends Drupal's Single Directory Components with **React, Vue, and
Svelte**. It lets you write components using modern JavaScript frameworks inside
Drupal's standard SDC folder structure, and it handles the parts that are usually
painful: the build pipeline, mounting, hydration, and server integration.

The design goal is progressive adoption without decoupling. You can drop a single
component into a Twig template — `{{ sdx('my_theme:hero', {title: node.label}) }}` —
or go all the way and replace Twig with a full framework-powered theme engine.
Either way you keep Drupal's admin UI, permissions, contextual links, cache tags,
and editorial workflows, because SDX components *are* Drupal components: they are
built natively on Drupal's plugin system, render pipeline, and cache infrastructure.
There is no REST API to maintain and no separate front-end deployment.

Around the core, SDX provides a modern build pipeline (Vite with hot module
replacement, automatic import maps and code splitting, SCSS/PostCSS, and TypeScript
support with types generated from your component schemas) and a family of optional
capabilities: client-side SPA navigation with prefetch and AJAX form handling,
clustered Node.js server-side rendering with Drupal cache-tag integration and a
circuit breaker, and reactive components you can build in pure PHP with server-owned
state. A separate companion project, **SDX DRAST**, replaces Twig entirely with a
structured-data pipeline. SDX targets Drupal 10.3+ and 11 and is an early release
(`1.0.0-alpha15`), so treat it as pre-production and test thoroughly.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and run the setup wizard.

## How to use it

Because SDX involves a JavaScript build pipeline, using it is more than enabling the
module. After installing, run SDX's setup wizard, which guides you through choosing a
framework (React, Vue, or Svelte), a bundler, and package setup. You then author
components in Drupal's standard SDC directory structure using your chosen framework,
and render them from Twig with the `sdx()` function or through a framework-powered
theme. Optional capabilities (SPA navigation, server-side rendering, reactive
components) are enabled as you need them. Consult the project's own README and the
`agent/` docs for the framework-specific workflow.
