# Anime.js — manual setup guide

**Anime.js** (`anime`) packages the [Anime.js](https://animejs.com/) JavaScript
animation library as a Drupal library so that other modules and themes can depend on it.
Anime.js is a small but capable animation library with a simple API; this module simply
makes it available to your site's code — it has no features or user interface of its own.

Because it is a library provider, you will not see anything change just by enabling it.
The actual animations are written by the theme or module that declares Anime.js as a
dependency.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable
   it.

## How to use it

Enable the module, then have your custom theme or module declare a dependency on the
Anime.js library in its `*.libraries.yml`. Your JavaScript can then use the Anime.js API
to animate elements.

A couple of things to confirm: serve the library locally if third-party origins are a
concern, and make sure the animation code you write respects the visitor's
`prefers-reduced-motion` setting — the library itself is neutral about motion; that
responsibility lives in the code that uses it.
