# Drupal Association Extras — manual setup guide

**Drupal Association Extras** (`drupal_association_extras`) is a container module
published by the Drupal Association to carry features that support Association
initiatives and programs. Each feature is meant to be independently switched on
or off, and the module is built on core's **Navigation** module — so whatever it
adds shows up in the admin navigation rather than as a standalone page.

It is worth being precise about what the module is *today*. At its current
`1.0.0-alpha1` release it is very nearly empty: it ships an install file and a
small test, but no settings form, no permissions, and no configuration of its
own. The first planned feature is promotion of Drupal hosting partners in the
admin UI (intended for the Drupal CMS trial experience), and future releases may
add things like DrupalCon promotion or upstream-support subscriptions. Expect the
contents to change substantially between alpha releases.

Because it is an alpha placeholder, install it only if you are participating in
an Association program that asks you to, or to understand what an inherited site
has it enabled for. There is nothing to configure — its only effect today is a
link in the navigation.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module. It has no settings form,
permissions, or routes of its own at this release.

## Where it lives in the admin menu

The module adds no dedicated settings page. Any functionality it provides is
surfaced through the core **Navigation** module's admin toolbar, so look there
after enabling it.
