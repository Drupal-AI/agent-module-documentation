# Scrollama JS — manual setup guide

**Scrollama JS** (`scrollamajs`) brings the [Scrollama](https://github.com/russellsamora/scrollama)
JavaScript library into Drupal. Scrollama is a modern, lightweight library for
building "scrollytelling" experiences — the kind of page where steps, captions, or
animations are triggered as the reader scrolls each element into view. It uses the
browser's efficient `IntersectionObserver` API rather than listening to every
scroll event, so it stays smooth even on long, media-heavy pages.

The module's job is simply to make the Scrollama library available to your theme
and modules as a Drupal asset library. It does not add any blocks, fields, or
settings of its own — there is no configuration form. You build the actual
scroll-driven behaviour in your own theme or module by attaching the library and
writing a small amount of JavaScript that tells Scrollama which elements are the
"steps" and what should happen as each one enters the viewport.

Because it is a pure front-end library integration, it changes only presentation.
It has no dependencies beyond Drupal core and supports a wide range of Drupal
versions (8.8 through 11). This is an early release (`1.0.0-beta1`), so test it
before relying on it in production.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

Enabling the module registers the Scrollama library. To put it to work, attach the
library from your theme or module (for example via a `#attached` render property or
a `*.libraries.yml` dependency) and write the JavaScript that sets up your scroll
steps. The [official Scrollama documentation](https://github.com/russellsamora/scrollama)
covers the API for defining steps and reacting to enter/exit events.
