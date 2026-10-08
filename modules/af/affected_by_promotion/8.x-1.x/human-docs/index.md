# Affected By Promotion — manual setup guide

**Affected By Promotion** (`affected_by_promotion`) is a reporting helper for
[Drupal Commerce](https://www.drupal.org/project/commerce). Given a particular
Commerce promotion, it shows you which entities — products and orders — that
promotion actually affects. In other words, it answers the question "what does
this discount actually apply to?" so a store manager can audit a promotion's
reach before or after it goes live.

It is purely informational: it reads Commerce's own rules about which entities a
promotion applies to and lists them for you. It changes nothing about how
promotions work, adds no storefront features, and has no access-control role of
its own. It depends on the **Commerce Promotion** module.

This guide is written for a **human** using the module through the admin UI. If
you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Commerce Promotion.

## How to use it

Once installed, use it against your existing Commerce promotions: for a given
promotion, the module lists the products and orders it affects, so you can confirm
a discount is hitting the intended items and no others. This is especially useful
when auditing a promotion whose conditions are complex, or when checking the scope
of a promotion before launching a campaign.
