# Bundle Redirect — manual setup guide

**Bundle Redirect** (`bundle_redirect`) lets you send a node straight to another
destination — configured per bundle (content type). A common use is a "link" or
"external resource" content type whose whole job is to forward visitors
elsewhere: with Bundle Redirect, nodes of that type automatically redirect to the
destination you set instead of showing a normal node page.

It builds on the contributed
[Redirect](https://www.drupal.org/project/redirect) module, which handles the
actual redirecting, and it adds its own permission so you can control who may set
these redirects. It runs on Drupal 8.8+, 9, 10, and 11.

The redirect destination is set by an administrator or editor (trusted input, as
with the Redirect module) — the module has no access-control role beyond its own
permission. As with any editor-set redirect target, it's worth keeping
destinations internal and expected so visitors aren't unexpectedly forwarded
off-site.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Redirect.

## Where it lives in the admin menu

Bundle Redirect adds no central settings page of its own. It works per bundle,
together with the Redirect module, and it provides its own permission (grant it at
**People → Permissions**, `/admin/people/permissions`) to control who can set
bundle redirects.

## How to use it

1. Grant the module's permission to the roles that should be able to configure
   bundle redirects.
2. For the content type (bundle) you want to forward, set the redirect
   destination. Nodes of that bundle then redirect to the destination
   automatically.

Keep destinations internal or expected so the redirect behaves predictably for
visitors.
