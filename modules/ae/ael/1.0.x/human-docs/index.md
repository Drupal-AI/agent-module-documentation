# As Event Listener — manual setup guide

**As Event Listener** (`ael`) is a small developer module that lets Drupal
modules register event listeners using Symfony's `#[AsEventListener]` PHP
attribute. Instead of declaring a tagged service in a `services.yml` file to hook
into an event, a developer can put the `#[AsEventListener]` attribute directly on
a class or method and have it registered automatically.

The point is convenience and modern style: it removes the `services.yml`
boilerplate that event subscribers usually require and brings Drupal event
handling in line with current Symfony practice. This is purely a framework
enhancement — it displays nothing to site visitors, adds no content, and plays no
role in access control on its own.

Because it relies on attribute-based listener registration that recent Drupal
core supports, it requires **Drupal 11.3 or newer**.

This guide is written for a **human** installing the module. If you want terse,
token-cheap references for an AI coding agent — which is really the audience for a
developer tool like this — read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

As Event Listener has no admin screen. Once it is enabled, developers use it
entirely in code: add the `#[AsEventListener]` attribute to a listener class or
method in a custom or contrib module, and the module takes care of registering it
as an event listener — no matching `services.yml` tag required. Everything else
about writing the listener (the event name, priority, and the handling logic) is
standard Symfony/Drupal event work.
