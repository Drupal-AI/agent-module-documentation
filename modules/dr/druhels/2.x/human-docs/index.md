# Drupal Helpers — manual setup guide

**Drupal Helpers** (`druhels`) is a developer utility library. It provides a
collection of general‑purpose helper functions — small, reusable static methods
that save you from re‑implementing the same boilerplate on every project. Rather
than adding any visible feature to your site, it is a base library that other
modules (and your own custom code) can call.

The helpers are grouped into convenience classes. A few examples from the project
page give the flavour:

- `NodeHelper::isNodePage()` — is the current page a node page?
- `NodeHelper::getCurrentNode()` — the node of the current node page.
- `DrupalHelper::getCurrentPageTitle()` / `getCurrentRouteName()` — the current
  page title and route name.
- `DrupalHelper::sendMail()` — send mail without having to implement `hook_mail()`.
- `FileHelper::getFileEntityByUri()` — the file entity for a given URI.
- `TaxonomyHelper::getAllChildTerms()` — all child terms, at any depth.
- `CommerceHelper::getCartsTotalPrice()` — the total price across carts.

…and many more. Because it is a base library, it has no content or access role of
its own, no settings, and nothing to click through — you install it and call its
functions from code. It supports a very wide range of Drupal versions (8 through
15) and is used by other modules such as Drupal Improvements.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it is a code library with no
settings and no admin UI.

## How to use it

Once the module is enabled, call its helper methods directly from your own module
or theme code. Add a `use` statement for the class you need (for example
`use Drupal\druhels\NodeHelper;`) and call the static method, such as
`NodeHelper::getCurrentNode()`. There is nothing to configure in the admin UI.
