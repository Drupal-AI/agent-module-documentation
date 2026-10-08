# Locale Override — manual setup guide

**Locale Override** (`locale_override`) provides a very simple user interface for
storing **overridden interface‑string translations as configuration entities**.
When you override a UI string through core's *Translate interface*, the override
normally lives only in the database — which makes it hard to move between
environments or hand to an external translation system. This module captures those
overrides as config entities instead, so they can be exported, version‑controlled,
and deployed like any other configuration.

Storing translated strings as config also makes it easier for a Translation
Management System (TMS) to pick them up and translate them, because they exist as
structured configuration rather than opaque database rows.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its dependencies.

Locale Override is used through its own list/add/edit forms (config entities)
rather than a single settings page — see "How to use it" below.

## Where it lives in the admin menu

Locale Override integrates with Drupal's configuration‑translation tools
(**Configuration → Regional and language**). It exposes a simple interface for
creating and managing string‑override config entities and a permission to control
who may do so.

## How to use it

1. Create a Locale Override entity for a UI string you want to override, providing
   the overriding translation. It is stored as configuration.
2. Export configuration (for example `drush config:export`) and commit the
   resulting override config to version control.
3. Deploy to another environment and import configuration there — the string
   overrides travel with your other config instead of being trapped in the source
   site's database. From there a TMS can also pick up the strings for
   translation.
