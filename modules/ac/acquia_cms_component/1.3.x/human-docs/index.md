# Acquia CMS Component — manual setup guide

**Acquia CMS Component** (`acquia_cms_component`) provides a set of **reusable
components** and their configuration for Acquia CMS — building blocks editors can
use to compose pages within the Acquia CMS ecosystem.

It is part of the **Acquia CMS** family and depends on `acquia_cms_common`. This
is a content-editing / site-building feature: the components are authored content
rendered through Drupal's normal layers, and the module has no access-control
role of its own. Like the rest of the family it ships as distribution
configuration — a standard component library rather than a generic, standalone
feature — so it is exactly right on an Acquia CMS site and carries the family's
assumptions elsewhere.

Enable it as part of the Acquia CMS setup to give editors the standard set of
page-building blocks.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its dependencies.

## Where it lives in the admin menu

This module has no dedicated settings page. It provides the component
configuration and building blocks that appear while editors compose content
through the Acquia CMS page-building experience — you'll encounter the components
in the content authoring UI rather than at a standalone admin path.

## How to use it

Once enabled, the standard Acquia CMS components are available to editors as
reusable building blocks when composing pages. There is nothing to configure to
start using them; they are ready as soon as the module (and the rest of the
Acquia CMS set it depends on) is in place.
