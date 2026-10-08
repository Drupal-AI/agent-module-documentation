# Stubby — manual setup guide

**Stubby** (`stubby`) creates stub API responses through a simple UI — a
development and testing tool for faking HTTP endpoints. In testing terms, a *stub*
replaces real behavior with a fixed, canned version: instead of calling a real
service, your code hits a stub that returns a predetermined response you can test
against. Stubby lets you create those stub API routes on the fly, complete with
custom response codes and messages, without writing code.

The problem it solves is testing and developing against API responses you don't
want to depend on the real service for. You can build a fake endpoint, define what
it returns (its JSON body, its HTTP status code, its message), and supply the JSON
either by pasting it in or by uploading a file. It also has a small system of
"pluggable parameters" for validating incoming requests — it ships default
"Required" and "Regex" parameter checks, each with its own error code and message,
and because those are plugins, other modules can add more to support a wider range
of test scenarios.

Stubby provides its own permissions and sits in the Development package. Because it
lets a user create endpoints and content-like data on the fly, treat it as a
**development-only tool**: gate its permission to trusted developers and do not
leave it enabled on a production site, where the ability to spin up arbitrary
endpoints is a privileged and potentially disruptive capability. It has no
access-control role beyond its own permission.

This guide is written for a **human** working through the admin UI. If you are an
AI coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

Once enabled, use Stubby's UI to create a stub: define the API route, set the
response status code and message, and provide the JSON response body by pasting it
or uploading a file. Optionally attach parameter checks (Required, Regex, or any
added by other modules) so the stub validates the incoming request and returns a
custom error code and message when a check fails. The stub then answers requests
to its route with your canned response, so you can develop and test against it.
Because this creates live endpoints, keep the Stubby permission restricted to
developers and keep the module out of production.
