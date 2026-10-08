# React — manual setup guide

**React** (`react`) makes the [React](https://react.dev/) JavaScript library
available to Drupal. It is a **developer module**: on its own it does nothing
visible on your site. Its job is to register the React / ReactDOM libraries — in
this 3.x branch, via **import maps** — so that other modules and your own custom
code can build React-based UI components without each bundling their own copy of
React.

Think of it as a thin wrapper that lets `import React from 'react'` resolve
correctly in the browser on a Drupal site. You then depend on it from your own
module's libraries and register your bundled code so the browser can find React
at runtime. It is intended to be used as a dependency by contrib or custom React
modules rather than enabled for its own sake.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, satisfy the
   Importmaps dependency, and enable it.

This module has **no configuration page** and no settings form — it only provides
libraries for developers to consume.

## How to use it (for developers)

1. Install and enable the module and its **Importmaps** dependency (see
   [Installation](installation/index.md)).
2. In your own build, mark **React** and **React-DOM** as *external* in your
   bundler (see your webpack or Vite documentation for how to externalise a
   dependency), so you don't ship a second copy of React.
3. Register your bundled code in a `*.libraries.yml` file and with the Importmaps
   module. The browser's import map then resolves `import React from 'react'` to
   the library this module provides.

The project deliberately stays minimal — it is just a way to add React to a
Drupal site cleanly and use it as a dependency for your React components.
