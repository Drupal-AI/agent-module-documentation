# FitText — manual setup guide

**FitText** (`fittext`) integrates the [FitText.js](https://www.drupal.org/project/fittext)
JavaScript library so that headline text scales fluidly to fill the width of its
container. Instead of a headline that stays one fixed size — too big on phones,
too small on wide screens — FitText "inflates" the type so a display heading
always fills the space it's given, no matter the viewport. It's a pure
front‑end/theming enhancement: it changes how text is sized in the browser and
touches nothing about your content or access model.

The module is aimed at site builders and themers who want big, responsive
display type without hand‑writing the JavaScript. It supports a wide range of
Drupal versions (8.8 through 11) and has no other module dependencies.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

FitText has **no central settings page** in the admin menu — it is a lightweight
theming helper that applies to the headline elements you point it at, so there
is no configuration chapter in this guide.

## Where it lives in the admin menu

FitText adds no page of its own to the admin menu. Once enabled, it works as a
front‑end enhancement that scales the headline text on your pages.

## How to use it

FitText is a theming tool: it makes the display text you target scale with its
container width. Use it on fluid or responsive layouts where you want a headline
to stay proportional to the space around it — for example a large hero title that
should look balanced on both a phone and a wide desktop. Because it works purely
in the browser, nothing about your content, permissions, or data changes when you
turn it on.
