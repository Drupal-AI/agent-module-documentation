# Masquerade Float Block — manual setup guide

**Masquerade Float Block** (`masquerade_float_block`) puts the
[Masquerade](https://www.drupal.org/project/masquerade) module's "switch user"
form into a **draggable, floating block** that appears on every page. Instead of
navigating to a user's profile to masquerade as them, an authorised user gets the
switch‑user form right where they are — handy for support and QA teams who switch
users constantly. The block can be dragged anywhere on screen, and it remembers
its position between page loads using a cookie.

It exists as an alternative to placing Masquerade's standard block through the
normal block layout. Because it is delivered by the module rather than block
configuration, you do not have to remember to add or remove a block from your
panels/layout when moving configuration between environments — you just toggle the
float block's *visible* setting.

> **What it does and does not do (verified):** the actual user‑switching is still
> performed by Masquerade's own form, which enforces Masquerade's `masquerade as
> …` permission model. This module does **not** add a new switch‑user path and
> does **not** let anyone become an account they could not already reach through
> Masquerade. It only *shows* Masquerade's form — to users who already hold a
> `masquerade as` permission (and always to user 1) — and gates the visibility
> toggle behind its own restricted permission. Impersonation is still powerful, so
> keep the underlying Masquerade permissions tightly scoped.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer
   (alongside Masquerade) and enable it.
2. [Configuration](configuration/index.md) — enable the float block, set
   permissions, and control when it shows.

## Where it lives in the admin menu

The settings form is at **Configuration → Development → Masquerade Float Block**
(`/admin/config/development/masquerade-float-block`).
