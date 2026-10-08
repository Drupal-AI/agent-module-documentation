# ScrollMagic — manual setup guide

**ScrollMagic** (`scrollmagic`) integrates the
[ScrollMagic](https://scrollmagic.io/) JavaScript library — the library for
"magical" scroll interactions. ScrollMagic lets you react to the visitor's current
scroll position: triggering animations, pinning elements in place, and building
parallax effects as the page scrolls. It is small (around 6KB gzipped), performant,
mobile-friendly, and supports scrolling in both directions and inside container
elements.

The base module simply makes the ScrollMagic library available to Drupal as an
asset library; the scroll effects themselves are things you set up in your theme or
via configuration. It ships an optional **ScrollMagic UI** submodule
(`scrollmagic_ui`) that provides an administrative interface for configuring scroll
scenes and effects, so you can define behaviour without hand-writing all the
JavaScript. It has no dependencies beyond Drupal core and supports Drupal 8.8
through 11. This is an early release (`1.0.0-beta1`).

Because it is a front-end library integration, it only affects presentation — it
does not change your content or anyone's access to it.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and optionally turn on the ScrollMagic UI submodule.

## How to use it

Enabling the base module registers the ScrollMagic library. To build scroll scenes,
either attach the library from your own theme/module and write ScrollMagic
JavaScript (see the [official ScrollMagic documentation](https://scrollmagic.io/docs/)),
or enable the **ScrollMagic UI** submodule to configure scenes and effects through
the admin interface.
