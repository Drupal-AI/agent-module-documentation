# XML-RPC — manual setup guide

**XML-RPC** (`xmlrpc`) restores the XML-RPC client and server that Drupal core
removed back in Drupal 8. XML-RPC is the classic pre-REST remote-procedure-call
protocol (`methodCall` over HTTP with XML payloads), and this module brings it back
so a Drupal 10/11 site can both **call** remote XML-RPC methods and **expose** its
own methods to external clients — most often to keep a legacy integration (blog
pings, pingbacks, MetaWeblog-style APIs, or a partner's XML-RPC endpoint) working
after upgrading from Drupal 7.

As a **client**, your code calls a single `xmlrpc()` function to POST a method call
to a remote endpoint and get the decoded result back (passing several methods at
once turns it into a `system.multicall` — one round trip, many calls). As a
**server**, the module registers a single route at `/xmlrpc` that answers incoming
calls. Out of the box the server only responds to the standard introspection
methods (`system.listMethods`, `system.methodSignature` and friends); real
application methods are added by other modules implementing `hook_xmlrpc()`.

**Please read this honestly before enabling it.** XML-RPC is a legacy,
security-sensitive protocol, and the server endpoint at `/xmlrpc` is
**unauthenticated and open to the world by design** — the expectation is that each
individual method does its own access control. The module itself is built
defensively: it parses requests with an expat SAX parser that does not resolve
external entities (so there's no XXE hole), and the dispatcher only ever calls
methods that were explicitly registered (a client can't name an arbitrary PHP
function). But the base module ships no application methods and no outbound-fetch
method, so any real risk comes from **contributed methods you or a module add** —
those must implement their own authentication and be careful about SSRF and state
changes, precisely because the endpoint is anonymous. Only enable this module if you
genuinely need XML-RPC interoperability.

The module has no admin UI, no permissions, no configuration and no Drush commands.
It depends on nothing beyond core (PHP 8.1.6+). A bundled **`xmlrpc_example`**
submodule demonstrates building both a client and a server.

This guide is written for a **human**. If you want terse, token-cheap references
for an AI coding agent — including the `xmlrpc()` API and the `hook_xmlrpc()` server
hooks — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and optionally enable the example submodule.

## Where it lives in the admin menu

Nowhere — there is no admin page. The module works entirely through code (the
`xmlrpc()` client function and the `hook_xmlrpc()` server hook) and the server route
at **`/xmlrpc`** (POST only). See the [`agent/`](../agent/start.md) docs for the
programmatic details.

## How to use it

- **Calling a remote endpoint:** custom code calls `xmlrpc($url, ['method.name' =>
  [$args]])` and receives the decoded return value (or `FALSE` on error). See
  [`agent/api/client.md`](../agent/api/client.md).
- **Serving methods:** a module implements `hook_xmlrpc()` to register method
  names and callbacks, which then answer at `/xmlrpc`. **Each method is responsible
  for its own access control** because the endpoint is anonymous. See
  [`agent/hooks/xmlrpc.md`](../agent/hooks/xmlrpc.md).
- **Learning by example:** enable the `xmlrpc_example` submodule to see a working
  client and server.
