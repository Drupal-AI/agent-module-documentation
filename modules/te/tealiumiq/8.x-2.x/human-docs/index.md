# Tealium iQ Tag Management — manual setup guide

**Tealium iQ Tag Management** (`tealiumiq`) connects your Drupal site to
**Tealium iQ**, one of the major enterprise tag managers alongside Google Tag
Manager and Adobe Launch. Rather than hand‑coding tracking scripts into your
theme, you add a single Tealium container (the `utag` loader), and your marketing
team adds, edits and removes tags inside Tealium's console — without needing a
Drupal deployment each time.

The real work this module does is building the **data layer**: a structured
description of the current page — its content type, section, publication date,
author, product identifier, and so on — that Tealium's tags read to decide what to
do. The module gives you an admin interface to manage default Tealium tags, lets
you set per‑entity tag values on standard fields (so they translate and version
like any other content), and uses the **Token** module so those values are pulled
automatically from the entity being viewed instead of being hard‑coded. It ships a
plugin interface for adding more tag types from custom modules, an event
subscriber for altering the data layer in code, and supports both synchronous and
asynchronous tag loading. A `tealiumiq_context` submodule integrates tag placement
with the Context module.

A few things are worth understanding before you deploy it. The module's two
permissions — *manage global tealium tags* and *administer tealium settings* — are
both marked restricted, and rightly so: **a tag manager can inject arbitrary
JavaScript into every page**, so anyone who can point your site at a container can
effectively run code in every visitor's browser. Treat those permissions like the
ability to deploy code. Second, **consent** applies to the container as a whole —
integrate it with your consent manager rather than assuming it is handled. And
third, **the data layer is a disclosure decision**: everything you put in it is
visible to every tag in the container *and* to anyone reading the page source, so
do not place personal data there without deciding to. It depends on core's
**Field** module and the contributed **Token** module, and runs on Drupal 10.2 and
11.

This guide is written for a **human** working through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the
   Token dependency), enable the module, and pick the Context submodule if you
   need it.
2. [Configuration](configuration/index.md) — enter your Tealium account details
   and manage default tags.

## Where it lives in the admin menu

The settings form (config object `tealiumiq.settings`) sits at **Configuration →
Web services → Tealium iQ** (`/admin/config/services/tealiumiq`).
