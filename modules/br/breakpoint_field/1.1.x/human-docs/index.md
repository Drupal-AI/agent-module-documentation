# Breakpoint Field — manual setup guide

**Breakpoint Field** (`breakpoint_field`) is a field type that lets an editor
pick a breakpoint group and then choose among the breakpoints that group defines,
storing that selection on the content. Breakpoints are the named screen-size
thresholds a theme declares in its `*.breakpoints.yml` file (mobile, tablet,
wide, and so on). This field surfaces them as an editorial choice.

The value is that responsive behaviour or per-breakpoint configuration can be
driven by what an editor selects, rather than being hard-coded in theme logic.
For example, content could carry a chosen breakpoint that a template or another
module reads to decide how to render it.

It is a field-provider / site-builder tool: it stores a selection and renders it
with normal escaping, and it has no access-control role of its own. It depends on
core's Field and Field UI modules and supports Drupal 10, 11, and 12. There is no
module-level settings page — you configure the field where you add it.

This guide is written for a **human** setting the module up through the admin UI.
If you want a terse, token-cheap reference for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — installing with Composer and enabling
   the module.

## Where it lives in the admin menu

Breakpoint Field has no settings page of its own. You use it from the **Field
UI**: add a field of this type to a content type (or other entity) under
**Structure**, and configure it there. The breakpoint groups it offers come from
the themes and modules installed on your site.

## How to use it

Add a Breakpoint Field to a content type through the Field UI. On the content
edit form, the editor selects a breakpoint group and then one of its breakpoints;
that choice is stored with the content. A template or another module can then read
the stored value to drive responsive behaviour — letting editors, not just
themers, decide the breakpoint that applies to a given item.
