# Bundle Reference — manual setup guide

**Bundle Reference** (`bundle_reference`) provides a new field type that
references entity **bundles** — the *types* — rather than individual entities. A
normal entity-reference field points at a specific node or term; a Bundle
Reference field instead points at a bundle definition, such as a content type, a
vocabulary, or a Paragraph type.

This is useful for configuration-driven behavior and site building: when your
content or configuration needs to say "this applies to the *Article* type" or
"use *this* Paragraph type," a Bundle Reference field stores that choice. Under
the hood it stores the bundle's machine name.

It is a fields / site-building feature with no content of its own and no
access-control role. It has no dependencies beyond Drupal core and runs on Drupal
8, 9, 10, and 11.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Bundle Reference has no settings page of its own. Like any field type, you use it
through Drupal's field UI — **Manage fields** on the entity/bundle where you want
the field (for example a content type at **Structure → Content types → (type) →
Manage fields**).

## How to use it

1. On the bundle where you want the field, go to **Manage fields → Add field**.
2. Choose the **Bundle reference** field type.
3. Configure the field like any other, then place it on the form and display.

When editors fill in the field, they pick a bundle (type); the field stores that
bundle's machine name for your templates, Views, or custom logic to act on.

> **Release status:** the current release is a beta (2.0.0-beta1).
