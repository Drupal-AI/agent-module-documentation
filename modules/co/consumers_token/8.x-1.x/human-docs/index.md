# Consumers Token — manual setup guide

**Consumers Token** (`consumers_token`) provides a single token,
`[consumers:current-name]`, that Drupal replaces with the name of the API
*consumer* making the current request. It's a small bridge between the
[Consumers](https://www.drupal.org/project/consumers) module and Drupal's token
system, built for decoupled ("headless") sites where one Drupal back end serves
several front-end applications.

The problem it solves is that Drupal has only one site name, but a decoupled
back end often feeds many front ends that each want their own branding. The
classic example is Metatags: a configuration like `[node:title] | [site:name]`
can only ever produce one site name. Swap in `[consumers:current-name]` and the
tag instead resolves to the name of whichever consumer requested it — so each
front-end application gets its own name in the output, driven by the Consumer
that made the API call.

The module works as soon as it is enabled: it simply registers the token, and
there is no settings form to fill in. You "configure" it by using the token in
any text or configuration that supports Drupal tokens (metatags, message text,
and so on). Its only dependency is the Consumers module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside its Consumers dependency.

There is **no configuration page** for this module — it adds no settings form.
You use it by placing the `[consumers:current-name]` token wherever tokens are
accepted, as described below.

## Where it lives in the admin menu

Consumers Token adds no admin page of its own. Consumers themselves are managed
by the Consumers module (typically under **Configuration → Web services →
Consumers**), and you place the `[consumers:current-name]` token in whatever
token-aware configuration you want to vary per front end.

## How to use it

1. Make sure you have one or more Consumers defined (via the Consumers module),
   each with a meaningful **name**.
2. In any token-aware field — for example a Metatag pattern — use
   `[consumers:current-name]` where you would otherwise hard-code a site name.
3. When a front-end application requests that content through the API, the token
   resolves to the name of the Consumer tied to that request, so each front end
   sees its own name.
