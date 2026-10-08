# Button Formatter — manual setup guide

**Button Formatter** (`button_formatter`) renders **link and file fields as
styled buttons** instead of plain text links. Turning a link into a call-to-
action button is a common need that often gets solved badly — a CSS class typed
into the link's own attributes, a template override for one field, or a Views
rewrite — all of which scatter styling decisions around the site. This module
centralises them.

It works in two levels. First, on a site-wide settings form you define the set of
button **styles** available (for example primary and secondary variants that match
your design system). Then, on any link or file field's display settings, the
Button Formatter is offered as a formatter with a **select box** to pick one of
those styles. Because the choice is part of the field display, it exports with
your configuration and applies consistently everywhere that display is used —
including in Views, when the field is rendered through its formatter.

The rendered markup comes from a single Twig template (`button-link.html.twig`),
so a theme can override the button markup in one place. Dependencies are core
only, and it supports Drupal 10 and 11. (The release still carries the legacy
`8.x-1.8` version string in its `.info.yml`.)

This guide is written for a **human** clicking through the admin UI. If you want a
terse, token-cheap reference for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — define the site's button styles and
   apply the formatter to a field.

## Where it lives in the admin menu

The site-wide button styles are defined on the settings form at
**Configuration → Button Formatter** (`/admin/config/button-formatter`), behind
the *administer button formatter* permission. Applying a style to a specific field
happens on that field's **Manage display** screen for the relevant bundle.
