# Normalize and Validate — manual setup guide

**Normalize and Validate** (`normalize_and_validate`) is a general‑purpose helper
module for developers. It provides reusable routines to **normalize** data (clean
and standardise it) and to **validate** it, so that modules and custom code can
enforce consistent, valid input without each reimplementing the same logic.

It is developer infrastructure rather than a feature you configure and use through
the UI. The module has no content type, no access role, and no visible front‑end
behaviour of its own — you enable it so that other code can call its helpers. It
supports Drupal 9, 10 and 11 and has no third‑party dependencies.

There is **nothing to configure** and no admin settings form. Once enabled, its
normalization and validation utilities are available to any code that depends on
it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** — the module is a developer library with no
settings. You typically install it because another module requires it, or because
your own code will call its normalize/validate helpers.

## How to use it

Normalize and Validate is a building block, not an end‑user feature. Enable it and
then call its helpers from your own module or theme code wherever you need to
standardise or check data — for example, cleaning up user‑supplied input before
saving it, or validating a value against expected rules. Because it centralises
this logic, you avoid re‑writing the same normalization and validation routines in
several places.
