# Bundle form — manual setup guide

**Bundle form** (`bundle_form`) lets developers give a single entity bundle its
own add/edit form, without changing the form for every bundle of that entity. In
plain terms: you can make the *Article* content type use a different edit form
from *Page*, or give one taxonomy vocabulary or one Paragraph type a customized
form — while every other bundle keeps the standard form.

It does this with a small plugin system. The module defines a `bundle_form`
plugin type; you write a plugin, annotate it with the entity type and bundle it
targets (for example Node / Article), and extend the module's base form. Inside
that plugin you can add fields, change validation, add a submit handler, hide
fields, or restructure the form — all scoped to just that one bundle. When someone
opens that bundle's add/edit form, the module automatically routes it to your
plugin. This keeps per-bundle form logic in its own class instead of a growing
`hook_form_alter()` full of `switch` statements.

This is a **developer / site-builder tool**. It has no routes, no permissions,
and no admin UI of its own — all behavior comes from the plugins you write in
code. A companion **examples submodule** (`bundle_form_examples`) ships ready-made
plugins for node, term, and paragraph bundles that you can copy as a starting
point. It runs on Drupal 11 and 12.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and optionally enable the examples submodule.

## Where it lives in the admin menu

Nowhere — Bundle form adds no admin pages or settings. It works entirely through
plugins you write in code.

## How to use it

1. Enable the **examples submodule** (`bundle_form_examples`) and look at the
   example plugins to see the pattern.
2. In your own module, create a plugin at
   `src/Plugin/BundleForm/{EntityType}/{Bundle}Form.php`, annotate it with the
   target entity type and bundle, and extend the module's base form.
3. Add or alter fields, validation, or submit handling for just that bundle. The
   module wires the form up automatically — there is nothing to configure in the
   UI.
