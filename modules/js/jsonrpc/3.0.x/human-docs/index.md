# JSON-RPC 2.0 — manual setup guide

**JSON-RPC 2.0** (`jsonrpc`) is developer infrastructure for building JSON-RPC 2.0 web
services in Drupal. It gives you a single endpoint at **`/jsonrpc`**, a plugin type for
defining callable "methods," automatic request/response validation against JSON Schema, and
per-method access control. It is the plumbing a decoupled or headless front end can call to
drive Drupal over RPC.

You expose functionality by writing **method plugins** — PHP classes tagged with a
`#[JsonRpcMethod]` attribute. Each method declares an id, its parameters (each validated
against a JSON Schema or built by a parameter factory), an output schema, and the
permissions required to call it. The module handles the rest: decoding the incoming request
(single or batched), mapping it to your method, checking access, executing it inside a
render context that captures cacheability, and returning a spec-compliant response — or a
proper JSON-RPC error object when something is wrong.

Access is enforced in two layers. Reaching `/jsonrpc` at all requires the `use jsonrpc
services` permission, and each method additionally checks its own declared permissions before
running. Which authentication providers are accepted on the endpoint (basic auth, OAuth2,
cookie, JWT) is chosen on a small settings form. Two optional submodules build on the base:
**JSON-RPC Core Methods** (`jsonrpc_core`) ships ready-made methods like cache rebuild and
maintenance mode, and **JSON-RPC Discovery** (`jsonrpc_discovery`) exposes a machine-readable
description of your API. This is a developer module and requires **PHP 8.3**.

This guide is written for a **human** setting the module up through the admin UI. If you
want terse, token‑cheap references for an AI coding agent — including how to author a method
plugin — read the sibling [`agent/`](../agent/start.md) docs instead.

> **Note:** a method authored with an *empty* access list is callable by anyone who
> holds `use jsonrpc services`. Decide carefully which roles get `use jsonrpc services`, and
> give methods an explicit permission.

## Contents

1. [Installation](installation/index.md) — install with Composer, meet the PHP 8.3
   requirement, and enable the module and submodules.
2. [Configuration](configuration/index.md) — choose the allowed authentication providers on
   the settings form.

## Where it lives in the admin menu

The settings form is at **Configuration → System → JSON-RPC**
(`/admin/config/system/jsonrpc`), gated by the `administer jsonrpc` permission. The service
itself answers at `/jsonrpc`. Methods are defined in code, not in the admin UI.
