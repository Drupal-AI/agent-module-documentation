# Scroll Depth Indicator — manual setup guide

**Scroll Depth Indicator** (`scroll_depth_indicator`) adds a real-time visual
progress indicator that fills as a visitor scrolls through a page, so readers can
see how far through the content they are. It is aimed at content-heavy pages and
long-form articles, where a progress cue helps people track their reading and
navigate lengthy pages more comfortably. The indicator is designed to be
lightweight and responsive, adapting to desktop, tablet and mobile without
getting in the way of navigation bars or sticky headers.

It works across any Drupal theme with CSS styling you can override to match your
brand, and it is performance-minded: it only appends the indicator where it is
needed and reads its settings through Drupal's config API. The module has no other
module dependencies and supports **Drupal 9, 10 and 11**. It carries official
security-advisory coverage.

Scroll Depth Indicator does have a **settings form**, so you get to decide where
the indicator attaches and on which content it appears — but sensible defaults mean
it works with little effort. You can control how the indicator is placed (by
element, CSS class or DOM ID), the exact selector it attaches to (defaulting to the
site header), and which content types it should appear on.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — requirements, installing with Composer,
   and enabling the module.
2. [Configuration](configuration/index.md) — where the indicator attaches, the
   selector it targets, and which content types it appears on.

## How to use it

Once enabled and configured, the indicator appears on the pages you have chosen —
typically as a bar near the top of the viewport that fills from empty to full as
the reader scrolls from the top of the content to the bottom. Developers can
override the shipped CSS to restyle it to match the site's design.
