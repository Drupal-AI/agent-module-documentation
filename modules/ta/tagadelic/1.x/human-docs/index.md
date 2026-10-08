# Tagadelic — manual setup guide

**Tagadelic** (`tagadelic`) builds *tag clouds* — weighted lists of terms where the
more often a term is used, the bigger it appears. It is one of Drupal's
longest-standing implementations of this classic content-discovery widget, turning
your taxonomy (or any countable, weighted list) into a cloud that visitors can use
to spot popular topics at a glance.

On Drupal, Tagadelic provides a **block** and a **page** showing the most-used
taxonomy terms, plus a **Views style** (the *Tagadelic List* style) that lets you
build a cloud from a View by choosing which field's value to count. For developers,
it is really a small set of classes with an API: by extending the abstract
`TagadelicCloudBase` class and overriding its `createTags()` method, you can build a
weighted cloud from anything you can count — the taxonomy cloud is just the shipped
example. (The Drupal 8+ version also folds in the functionality that used to live in
the separate Views Tagadelic module.)

It depends on core's **Block** and **Taxonomy** modules. It is purely a display
module with no security-sensitive surface. Worth a moment's thought before you add
it: tag clouds have gone somewhat out of fashion and can be a weak navigation aid on
very large vocabularies, so consider whether a cloud or a more structured facet
better suits your content — but where you do want a cloud, this builds it, and its
settings are deliberately kept simple and self-explanatory.

This guide is written for a **human** clicking through the admin UI. If you are an
AI coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

Once enabled, there are three main ways to surface a cloud:

- **Block:** place the Tagadelic block through **Structure → Block layout** to show
  a cloud of the most-used taxonomy terms in a region of your theme.
- **Page:** Tagadelic provides a page listing taxonomy terms as a weighted cloud.
- **Views style:** in any View, pick the **Tagadelic List** style, then configure
  which field the cloud should count to size each term. Three example Views ship
  with the module to get you started.

The settings for each are kept simple and self-explanatory, so there is no separate
configuration screen to walk through.
