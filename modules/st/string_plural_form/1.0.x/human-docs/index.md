# String Plural Form — manual setup guide

**String Plural Form** (`string_plural_form`) gives site administrators a
user interface for choosing the plural-form rules used when translating strings.
Different languages count plurals differently — English has two forms (one item /
many items), while several Slavic and other languages have three, four, or more
plural categories — and Drupal needs the right rule so that `format_plural()` and
translated strings render the correct wording for each count.

Drupal core already lets you set plural rules, but only by uploading a Gettext
(`.po`) file with the correct plural formula in its header — which is awkward if
all you want is to pick the standard rule for a language. This module removes
that friction: as a site admin you select the appropriate plural form for each
enabled language from a list of available rules, right in the admin UI. It also
provides a small plugin system so other modules can define custom plural-form
rules.

The module depends only on core's **Locale** module (which ships with Drupal),
provides its own permissions, and has no content or access-control role of its
own. It works on Drupal 10.2+ and 11. There is one thing to do after enabling it:
visit its configuration page and pick the rules for your languages.

This guide is written for a **human** working through the admin UI. If you are an
AI coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — choose the plural-form rule for each
   language after installing.

## Where it lives in the admin menu

After enabling the module, its settings page sits under **Configuration →
Regional and language → Languages** at
`/admin/config/regional/language/string-plural-form`.
