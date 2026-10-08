# Texts — manual setup guide

**Texts** (`texts`) gives a home to the strings that are neither content nor code:
a call-to-action label, a standard disclaimer, the help sentence above a form. It
lets you manage and translate these reusable snippets with a key-based approach —
you refer to a string by a key such as `login.button`, and edit its wording (and
its translations) in one place instead of hunting through templates and blocks.

Every site accumulates these strings, and without somewhere to put them they end
up hard-coded in templates (needing a deployment to change), stored in blocks
(deployable but heavy for a single sentence), or simply duplicated in several
places until the copies disagree. Texts solves that with an improved backend UI
for managing translations, support for pluralization (singular/plural) and
placeholders just like Drupal's `t()` function, and CSV import/export so you can
hand all your strings to an external tool for translation and bring them back.

The module is especially useful in a **decoupled/headless** setup. Its optional
**Texts GraphQL** submodule (`texts_graphql`) exposes the snippets to a GraphQL
consumer, so a separate front end can read exactly the same strings the Drupal
side uses instead of hard-coding its own copies. Developers can also fetch strings
in PHP with the `getTexts()` / `getTextsPlural()` functions or in templates with
the `getTexts` / `getTextsPlural` Twig filters. Texts requires Drupal 10 or 11 and
installs with no dependencies of its own; it works alongside core's Locale and
Content Translation modules.

One thing worth deciding deliberately before you adopt it is **who owns the
strings**. Managed as configuration they deploy with your codebase and are
reviewable in a diff, but an editor cannot change the wording without a
deployment. Managed as content the opposite is true — instantly editable, but
absent from your configuration export. The right answer depends on whether each
piece of wording is a design decision or an editorial one, and it is worth
settling on purpose.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install and enable the module, plus the
   optional GraphQL submodule.
2. [Configuration](configuration/index.md) — the management screen, CSV
   import/export, and hiding languages from the overview.

## Where it lives in the admin menu

The module's management and configuration screen is at **Configuration → Regional
and language → Texts** (`/admin/config/regional/texts`). That is where you manage
your snippets, run CSV import/export, and choose which languages to show in the
overview.
