# Notify Manager — manual setup guide

**Notify Manager** (`notify_manager`) is a module for managing and dispatching
site notifications. Its aim is to give a site one central place to control its
notification flows — defining notifications, queuing them, and dispatching them
to users through configured channels — rather than scattering that logic across
many modules. In the maintainer's words, it "helps users maintain the
notifications which will be created by the admin and other specific groups."

It has **no other module dependencies** and works across a wide span of Drupal
versions (**9, 10, and 11**). It declares permissions of its own, which is how it
distinguishes who may manage and dispatch notifications from ordinary users.

The publicly available documentation for this module is light — the project page
points to Drupal.org's contributed‑module documentation for the details rather
than spelling out every screen. This guide therefore covers installation and the
general shape of how it is used; for the specifics of any given form, consult the
project's own documentation on Drupal.org.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

Once enabled, Notify Manager acts as the hub for your site's notifications:
administrators (and any other groups you grant the module's permissions to)
define notifications, which the module queues and dispatches to users through the
channels it is set up with. Grant the relevant permissions at **People →
Permissions** so the right people can create and manage notifications, then
follow the project's Drupal.org documentation to define your notification flows.
