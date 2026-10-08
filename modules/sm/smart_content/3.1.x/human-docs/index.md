# Smart Content — manual setup guide

**Smart Content** (`smart_content`) is a framework for real-time, anonymous
website personalization on Drupal. It lets you show different content to different
visitors based on conditions evaluated *in the browser* — things like language,
device type, cookies, local storage, UTM parameters and more — without breaking
page caching. Out of the box it can show one thing to anonymous visitors and
another to authenticated users, and it's the foundation for lightweight A/B and
segment testing.

The model has four moving parts. A **condition** is a single true/false test (for
example "is on a mobile device"). One or more conditions make up a **segment**,
and segments are grouped into a **segment set**. A **decision** evaluates those
segments against the visitor's data and fires a **reaction** — most commonly
swapping in different block content. Because the decision is evaluated client-side,
the page itself stays cacheable: the browser collects the condition data and calls
a reaction endpoint over AJAX (keyed by an unguessable per-placement UUID token) to
fetch the content that matches.

Smart Content provides limited functionality entirely on its own — it's a toolset
meant to be combined with companion modules. The bundled **Smart Content Blocks**
submodule lets you place a Decision Block anywhere you can place a block (including
via Layout Builder in the 3.x line), and **Smart Content Browser** supplies the
browser-based conditions. A wider family of modules extends it further — Data
Layer, CDN, Lytics, Paragraphs, Preview, SSR, A/B, UTM and connectors for
Demandbase and 6sense.

This guide is written for a **human** working through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

> **Important — this is not access control.** Smart Content is *not* a substitute
> for server-side access control. Conditions are evaluated in the browser, where a
> knowledgeable person can view, change or manipulate them. Use it to improve the
> user experience and to vary content by context — never to restrict access to
> protected content, and don't use it to evaluate conditions that contain
> personally identifiable information.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable Smart
   Content (and typically the bundled block submodule), and grant the permission.

## Where it lives in the admin menu

Segment sets and the module's settings live under **Administration → Structure →
Smart Content** (`/admin/structure/smart-content`), gated by the **administer
smart content** permission.

## How to use it

You author personalization by placing a **Decision Block** on a page — either
through the normal block layout or with Layout Builder — and then configuring its
segments and the reactions each segment should fire. Build segments from the
available condition plugins, combine conditions with AND/OR grouping and negation,
and reuse segment sets across multiple placements. At runtime the browser gathers
the condition data and requests the matching reaction over the module's AJAX
endpoint, so visitors see personalized content while your pages stay cacheable.
The condition, reaction and decision systems are all pluggable, so developers can
add custom conditions and reactions of their own.
