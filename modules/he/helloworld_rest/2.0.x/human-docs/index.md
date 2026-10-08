# Hello World REST — manual setup guide

**Hello World REST** (`helloworld_rest`) adds an example custom resource to
Drupal's core REST API. It is a "hello world" demonstration that shows developers
how to expose their own REST resource plugin — the returned response is a simple
sample payload rather than anything you would use in production.

The resource is served through core's **REST** module, so it plays by core REST's
rules: you enable and expose the resource, choose its formats and authentication,
and grant the per‑resource **GET** permission to the roles that should be able to
call it.

Because this is **example / reference code, not a production feature**, treat it as
a learning aid or a boilerplate to copy when building a real REST endpoint of your
own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and enable its core REST dependency.

There is **no dedicated settings page** for this module. Its behavior is controlled
entirely through core REST configuration and permissions, described below.

## How to use it

1. Make sure core's **RESTful Web Services** (`rest`) module is enabled — it is a
   dependency and Drupal enables it for you.
2. Expose the example resource through your usual REST tooling (for example the
   [REST UI](https://www.drupal.org/project/restui) contrib module, or a
   configuration file), choosing the request formats and authentication providers
   you want.
3. At **People → Permissions** (`/admin/people/permissions`), grant the resource's
   **GET** permission to the roles that should be allowed to call the endpoint.
   Without that permission a request is denied.
4. Call the resource and inspect the example response to see how a custom REST
   resource plugin is wired together.
