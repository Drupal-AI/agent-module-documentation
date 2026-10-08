# Conditional Content Block Rendering — manual setup guide

**Conditional Content Block Rendering** (`conditional_rendering`) fills a gap in
**Layout Builder**: it lets you show or hide a content block based on runtime
conditions, without writing any code. You attach rules to a content block, and
when that block appears in a Layout Builder layout the module decides whether to
render it by comparing token values against the values you set.

The approach is deliberately simple: each rule compares a **token** (for example
`[current-user:uid]` or `[node:field_x]`) against a **value** using an
**operator** (equals, contains, greater than, a regular expression, and many
more). You choose an overall **action** — *Show* or *Hide* — and you can add as
many conditions as you like; they are combined with logical **AND**. So you can,
for instance, show a call-to-action block only to logged-in users, or hide a
promotional block outside a targeted context.

The module depends only on core's **Layout Builder**. It has **no settings page**
and adds no admin menu items — instead it adds two fields to every content block.
The optional **Token** module isn't required, but installing it gives you a handy
token browser so you can discover which tokens are available.

A note on trust: the conditions (including regular expressions) are authored by
users who can edit block content, so they are treated as trusted editor
configuration, not anonymous input. Grant block-content editing accordingly.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module (and optionally Token), with Layout Builder as the only dependency.

There is **no configuration page** for this module — the setup happens on each
content block, described below.

## How to use it

1. Enable the module (see [Installation](installation/index.md)) and make sure
   **Layout Builder** is enabled for the entity display you're working with.
2. Create or edit a **content block** (**Content → Blocks**, or inline while
   editing a Layout Builder layout). You'll find a new section for defining
   rendering conditions, with:
   - **Conditional Rendering Action** — choose **Show** or **Hide**.
   - **Conditions** — add one or more rows, each with a **property** (a token), an
     **operator**, and a **value**.
3. Add as many conditions as you need. Remember they are combined with **AND** —
   for a *Show* action every condition must pass; for a *Hide* action a passing
   condition hides the block.
4. Save the block and place it in a Layout Builder layout. The block is evaluated
   at render time (evaluation is skipped in Layout Builder *preview* so you can
   still see and edit it there).

> **Tip:** Install the optional **Token** module to browse the available tokens
> when filling in the property field.
