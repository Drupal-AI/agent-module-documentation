# ScrollReveal JS — manual setup guide

**ScrollReveal JS** (`scrollrevealjs`) integrates the
[ScrollReveal.js](https://scrollrevealjs.org/) JavaScript library into Drupal.
ScrollReveal makes it easy to animate elements as they enter or leave the viewport
— fade, slide, and scale effects that play as the reader scrolls an element into
view — without you having to write the underlying animation code yourself.

The module's role is to make the ScrollReveal library available to your theme and
modules as a Drupal asset library. It adds no blocks, fields, or settings form of
its own. You decide which elements animate, and how, by attaching the library and
writing a small amount of JavaScript that points ScrollReveal at your target
elements. It has no dependencies beyond Drupal core and supports Drupal 8.8 through
11. This is an early release (`1.0.0-beta2`).

Because it is a pure front-end library integration, it changes only presentation —
your content and access rules are untouched.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

Enabling the module registers the ScrollReveal library. To add reveal-on-scroll
animations, attach the library from your theme or module and write the JavaScript
that tells ScrollReveal which elements to animate and with which effect. The
[official ScrollReveal guide](https://scrollrevealjs.org/) documents the API.
