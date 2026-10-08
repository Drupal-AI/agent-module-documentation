# Better Unpublished Terms — manual setup guide

**Better Unpublished Terms** (`better_unpublished_terms`) tightens how Drupal
handles taxonomy terms that are **unpublished**, so they aren't shown to users
who shouldn't see them. Core's handling of unpublished terms leaves gaps — an
unpublished term can still surface in listings, term-reference displays,
autocomplete results and forms — and this module aims to close that exposure.

It is a security-positive access-control module: its goal is to hide, not
reveal. It depends on core Taxonomy and on the Inline Entity Form module, and
it lives in the Custom package. It adds no permissions of its own; term access
ultimately still relies on core taxonomy access plus these improvements.

Because coverage depends on where terms appear in your site, treat this as a
hardening layer rather than a guarantee: after enabling it, verify it covers
the specific paths you care about (term pages, term-reference field displays,
autocomplete, and Views listings) for your particular configuration.

This guide is written for a **human** clicking through the admin UI. If you
want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

There is no settings form. Once enabled, the module's tighter handling of
unpublished terms applies automatically. Manage which terms are published or
unpublished the usual way when editing a term at **Structure → Taxonomy**
(`/admin/structure/taxonomy`). After enabling, spot-check that unpublished
terms no longer appear where you don't want them — on term pages, in fields
that reference terms, in autocomplete suggestions, and in any Views that list
terms.
