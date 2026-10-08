<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API Token Entity — manual setup guide

**API Token Entity** (`api_token_entity`) lets you create, manage and consume API
tokens, modeling both the tokens and their **token types** as Drupal entities. The
idea is that other modules or custom code can issue and validate API tokens to
authenticate incoming API requests — with expiry support built on core's Datetime
module — rather than each integration inventing its own token store.

Because the things this module stores are **credentials**, treat them as
sensitive. Tokens should be validated using a constant-time comparison (to avoid
timing attacks), given sensible expiry dates, and their administration restricted
to trusted roles. The module gates token administration behind the
**`administer api_token_entity entities`** permission — grant it only to
administrators you trust to mint and revoke API credentials.

The module depends on Drupal core's **Datetime** module (for token expiry) and
requires **Drupal 11.3 or newer**. It provides its own permissions.

This guide is written for a **human** setting the module up through the admin UI.
Consuming and validating tokens from code is a developer task; for that, read the
sibling [`agent/`](../agent/start.md) docs.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

## Where it lives in the admin menu

Tokens and token types are managed as entities, gated by the **`administer
api_token_entity entities`** permission. Grant that permission (**People →
Permissions**) only to trusted administrator roles before you start issuing
tokens.

## How to use it

1. Enable the module and grant **`administer api_token_entity entities`** to the
   roles that should manage tokens.
2. Define token types as needed, then create the API tokens themselves — setting an
   **expiry** date so credentials don't live forever.
3. Have your API-consuming code validate an incoming token against the stored token
   entities (using a constant-time comparison), and honour the expiry.

Treat the token values as secrets throughout: hand them out over secure channels,
store them carefully on the client side, and revoke (or let expire) any token you
suspect is compromised.
