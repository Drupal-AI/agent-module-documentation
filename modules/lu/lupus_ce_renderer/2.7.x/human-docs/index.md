# Lupus Custom Elements Renderer — manual setup guide

**Lupus Custom Elements Renderer** (`lupus_ce_renderer`) turns Drupal into an API
backend that delivers a page's **main content and metadata only**. Instead of
rendering themed HTML, it renders each page into a tree of **custom elements**
(one semantic element per component) and returns a JSON response containing the
page's metadata together with that content — either as serialized custom‑element
markup or as a JSON data structure. A decoupled front end then owns how each
component actually looks.

It works by adding a new **`custom_elements` response format**: append
`?_format=custom_elements` to any URL and the page is processed through Drupal's
normal routing, authentication, and request handling, then returned in this
format. Because Drupal's pipeline stays in charge, all the usual routing, access
checks, caching, and metadata generation keep working — which is the whole
argument for this approach over a front end that has to reimplement rendering,
caching, and access from raw data.

This module is the **delivery half** of a decoupled architecture: it pairs with
the [Custom Elements](https://www.drupal.org/project/custom_elements) module
(which produces the elements) and [Metatag](https://www.drupal.org/project/metatag)
(so SEO metadata travels in the payload rather than being retrofitted). It is one
of the building blocks behind
[Lupus Decoupled](https://www.drupal.org/project/lupus_decoupled) (Drupal + a
Nuxt.js front end), but it can be used on its own with any front‑end technology
that renders custom elements.

> **Two things worth holding onto.** First, because Drupal keeps doing the
> access checks, a component rendered for a specific user must carry the right
> **cache contexts** — exactly as in a coupled site — or it may be cached and
> served to the wrong audience. Second, the **element and attribute names you
> emit are an API**: renaming one is a breaking change for the front end, so they
> deserve versioning, documentation, and an owner.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside its Custom Elements and Metatag dependencies.

There is **no dedicated settings form** for this module. It works by exposing the
`custom_elements` response format; how components map to elements is governed by
the Custom Elements module and your own code. See "How to use it" below.

## How to use it

1. Install and enable the module and its dependencies (see
   [Installation](installation/index.md)).
2. Request any page with the new format appended, for example
   `/node/1?_format=custom_elements`. The response is JSON carrying the page's
   metadata plus its content as custom elements.
3. If you are building the full Lupus Decoupled stack, the
   [Lupus Decoupled](https://www.drupal.org/project/lupus_decoupled) module wraps
   this behind a convenient `/ce-api/` prefix and adds the CORS, menu, form, and
   view bridges a real front end needs.
4. Point your front end (Nuxt.js or otherwise) at those responses and render each
   custom element as a component.
