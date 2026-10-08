# Supported Image Delta Formatter — manual setup guide

**Supported Image Delta Formatter** (`supported_image_delta_formatter`) is a display
formatter that lets you show only **specific values (deltas)** of a multi-value
**Supported Image** field — for example, render just the first image, or a chosen
subset, rather than all of them.

It solves a common display problem: you have a Supported Image field that holds
several images, but in one particular display you only want to show one of them (say
a "lead" image) or a specific few. This formatter, adapted from the well-known
**Image Delta Formatter** project, gives you that per-display control over which
deltas render and through which image style. A bundled **Responsive Supported Image
Delta Formatter** sub-module adds responsive image style support for the same
purpose.

This is a pure display formatter — there is no global settings page. You select it
and configure it on a field's display settings. It depends on the **Image Delta
Formatter** module and the **Supported Image** module, and it targets Drupal 10 and
11.

This guide is written for a **human** setting the formatter up through the admin UI.
If you are an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

1. Go to the **Manage display** page of the entity whose multi-value Supported Image
   field you want to control.
2. Change that field's format to **Image delta**.
3. Click the gear icon next to the formatter to configure it — choose which image
   style to use (if any) and which values (deltas) to display.
4. Save the display settings.

Enable the bundled **Responsive Supported Image Delta Formatter** sub-module if you
need responsive image styles on the selected deltas.
