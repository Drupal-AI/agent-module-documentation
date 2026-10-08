# Senthor — manual setup guide

**Senthor** (`senthor_io`) connects your Drupal site to the Senthor WAF
service so you can see, control, and even monetize the AI crawlers that fetch
your content. Generative-AI systems scrape huge volumes of published articles
every day, usually without the publisher's permission or any share of the
revenue. Senthor is designed to hand that control back to you.

Technically, the module adds a small piece of HTTP middleware that watches
incoming front-end page requests. For each eligible request it asks the Senthor
service — over HTTPS — whether the visitor should be allowed through, blocked, or
charged. Based on that answer it either lets the page render normally, returns a
"403 Forbidden", or returns a "402 Payment Required" and passes along any
monetization headers. Admin pages, AJAX calls, and Drupal's internal
sub-requests are always skipped so you can never lock yourself out of the
back end.

The module works the moment you enable it — there is **no settings form inside
Drupal** in this version, and nothing you must configure locally. All of the
real setup (creating an account, adding your domain, and choosing your
allow/block/monetize rules) happens on the Senthor side at
[senthor.io](https://www.senthor.io). It depends only on Drupal core's System
module and adds no database tables or config of its own.

One thing to be aware of before you enable it: by design, the module sends
request metadata — the request URL, the visitor's IP address, and the request
headers — to the Senthor service for every eligible front-end request. Sensitive
headers (`authorization`, `cookie`, `set-cookie`, `x-csrf-token`) are stripped
out before anything is sent, and the connection uses normal TLS verification. Even
so, it means a third party sees traffic metadata for your public pages, and each
eligible request makes one external round-trip, so there is a small latency and
privacy cost worth weighing.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and finish setup on the Senthor dashboard.

## How to use it

Once enabled, the middleware is active automatically for non-admin GET requests —
there is nothing to click inside Drupal. To actually monitor traffic and decide
who gets allowed, blocked, or charged, create a free account at
[senthor.io](https://www.senthor.io), add your domain (for example
`www.yoursite.com`) in the Senthor dashboard, and manage your rules there.
