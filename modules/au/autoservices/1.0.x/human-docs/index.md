# Autoservices — manual setup guide

**Autoservices** (`autoservices`) is a developer tool that lets a module register
container services without writing a `*.services.yml` entry for them. Drop a class
into a module's `src/Autoservice/` directory, type‑hint its constructor with the
interfaces it needs, and the class is registered as a service — with **autowiring**
enabled — under its fully qualified class name. No YAML, no listing each argument in
the right order.

The point is to remove boilerplate that's easy to get wrong. Symfony has supported
autowiring for years, and Drupal core supports `autowire: true` — but the service
definition still has to exist, so adding a service stays a two‑file job: write the
class, then describe it in YAML restating what the constructor's type hints already
say. That YAML is where the mistakes happen (an argument in the wrong position, a
service id mistyped, a constructor changed without the YAML following). Autoservices
does away with it. For autowiring to work it needs to know which service implements
which interface, and Drupal doesn't publish that mapping, so the module also
registers **aliases for many core services** — that alias set is the real substance
of the module, and the first thing to check if a particular interface won't resolve.

Its own README is explicit that the module **does nothing on its own** and should be
installed as a dependency of another module that adopts the convention. Weigh one
trade‑off before adopting it widely: services registered by convention don't appear
in any YAML file, so Drush service listings and a plain text search for a service id
won't find them, and a developer who hasn't met the convention won't know where they
came from. That's the usual cost of convention over configuration — worth choosing
deliberately.

This guide is written for a **human** developer. If you want terse, token‑cheap
references for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [How to use it](#how-to-use-it) — register a service by dropping in a class.

## Where it lives in the admin menu

Nothing. Autoservices has no admin menu item and no settings form — it is a
code‑level developer tool with no user interface.

## How to use it

1. Install and enable Autoservices, typically as a **dependency** of the module that
   will use it (declare it in that module's `.info.yml`). On its own it has no
   effect.
2. In your module, create the directory `src/Autoservice/` and place a service class
   in it.
3. Type‑hint the class's constructor with the **interfaces** of the services it
   depends on. The class is registered as a service under its fully qualified class
   name, with autowiring resolving those dependencies from the registered aliases.
4. If a particular dependency fails to resolve, check the module's **core‑service
   alias set** — that's what maps an interface to the concrete core service. Remember
   that services registered this way won't show up in Drush service listings or a
   text search for a service id.
