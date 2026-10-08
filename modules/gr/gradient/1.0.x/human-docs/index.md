# Gradient — manual setup guide

**Gradient** (`gradient`) provides a **gradient‑builder form element** — a small
UI widget for composing a CSS gradient by choosing its colours, stops and
direction — together with a service that turns those choices into a
`linear-gradient` CSS rule. It's a building block for page‑building and theming
work: wherever you want an editor or administrator to pick a gradient rather than
type raw CSS, you can use this element and get a valid CSS value back.

Gradient is primarily a **developer/site‑builder utility**. It doesn't add a page
or feature that end users see directly; instead it supplies a reusable form
element (and a service to generate the CSS rule) that other forms, modules or
theming configuration can incorporate. The gradient value it produces is an
admin/editor‑configured CSS value, so output it in the usual safe way wherever you
render it.

It has **no configuration page**, no permissions, and no content or access role of
its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no settings form** for this module — it exposes a form element and a
service for use in other forms and code.

## How to use it

Enable the module and then use the gradient form element wherever your own form or
configuration needs a gradient picker. The accompanying service generates the
`linear-gradient(...)` CSS rule from the element's value, which you can then apply
in a template, inline style, or generated stylesheet. Because the result is a CSS
value chosen by an administrator or editor, render it through Drupal's normal safe
output so it appears only where you intend.
