# Symfony Messenger — manual setup guide

**Symfony Messenger** (`sm`) brings the Symfony Messenger component — a modern
**message bus** — into Drupal. It gives developers a clean way to dispatch
"messages" (units of work) onto a bus and have handler services process them,
optionally **asynchronously** over a transport, separately from the web request.
Think of it as a more capable alternative to Drupal's core Queue API, with
Messenger's routing, middleware, and prioritisation.

The problem it solves is background and async processing: instead of doing slow
work inside a page request or hand-rolling queue workers, you dispatch a message
and let a consumer process it later — the same pattern Symfony applications use.
It ships with a Drupal SQL native transport out of the box, and there is a whole
ecosystem of companion projects for other transports (AMQP, Redis, Doctrine),
scheduling, metrics, monitoring, and asynchronous mail.

This is **developer infrastructure**. Enabling it doesn't change anything a
visitor sees; it provides the bus and tooling your custom code (and other
modules) build on. It carries an `sm_config` submodule for configuration. It
works on Drupal 10.5+ and 11.2+, is covered by Drupal's security advisory
policy, and all its non-Drupal dependencies are managed by Composer.

A note on security: Symfony Messenger itself has no fixed public attack surface.
The security lives in **what your messages carry and how their handlers act** — a
handler runs with site privileges, so review handlers and validate message
contents. If you configure an **external transport** (a message broker), protect
its credentials and be mindful that message payloads pass through it.

This guide is written for a **human** installing the module. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

Symfony Messenger is used from **code and the command line**, not an admin form.
Once enabled you dispatch messages onto the bus from your custom code and write
handler services to process them; a consumer command processes queued messages
asynchronously. The bundled Drupal SQL transport works without any external
infrastructure — add one of the companion transport modules (Redis, AMQP,
Doctrine) only when you need a different backend. See the module's extensive
README and the PreviousNext "Symfony Messenger" blog series for developer
guidance.
