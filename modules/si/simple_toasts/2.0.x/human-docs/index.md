# Simple Toasts — manual setup guide

**Simple Toasts** (`simple_toasts`) replaces Drupal's standard inline status
messages with dismissible floating "toast" notifications — the small pop-up notices
that slide into a corner of the screen and can be clicked away. It works for every
kind of message: status, warning and error, including messages created by Ajax and
by JavaScript `Drupal.Message()` calls.

The appeal is a more modern, less layout-disruptive way to show feedback. Instead of
a block of messages pushing your page content down, a toast floats over the page,
optionally animates in, and disappears on its own after a while. It is purely a
front-end presentation change — it does not alter what messages Drupal generates or
touch any access behaviour, and it needs no additional JavaScript libraries.

Once enabled you tell it which of your active themes should use toasts, and then tune
the look per theme: the message style (the theme's own or one of the module's
presets), the on-screen position, how long each message type stays before it fades,
and the animation style. All of that lives on a single settings form.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — choose which themes use toasts and tune
   their position, timing and animation.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → User Interface → Simple
Toasts Settings** (`/admin/config/user-interface/simple-toasts/settings`).

> **Upgrading from 1.1.x?** There is no upgrade path from version 1.1.x to 2.0.x. If
> you are moving up, uninstall the old version before updating.
