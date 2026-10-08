# Devel Accessibility — manual setup guide

**Devel Accessibility** (`devel_a11y`) is an add-on for the popular
[Devel](https://www.drupal.org/project/devel) module that adds front-end
debugging aids for accessibility. Some of Drupal's most important accessibility
behaviour happens in JavaScript and is completely invisible on screen: the
`Drupal.announce()` function pushes messages into an ARIA live region for screen
readers, and the "tabbing manager" traps keyboard focus inside modals and
off-canvas dialogs. When either misbehaves, there is nothing to see. This module
makes them observable.

It provides three aids, all on by default. One logs every screen-reader
announcement to your browser console, one logs the tabbing manager's activity,
and one draws the current keyboard-focus constraint directly on the page so you
can see exactly which region has focus trapped. Because they attach through
Devel's own permission, only users who can access Devel information see them.

Like Devel itself, this is a development tool — the aids load on every page for
anyone who can reach them, so keep the module disabled on production sites.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Devel.
2. [Configuration](configuration/index.md) — the settings form, where you switch
   each of the three aids on or off.

## Where it lives in the admin menu

Its settings form sits under Devel's own configuration at **Configuration →
Development → Devel → Accessibility** (`/admin/config/development/devel/a11y`).
The form is gated by Devel's **Access developer information**
(`access devel information`) permission — the module does not add a permission of
its own.
