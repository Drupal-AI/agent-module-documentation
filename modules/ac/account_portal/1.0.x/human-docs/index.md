# Account Portal — manual setup guide

**Account Portal** (`account_portal`) provides a self-service account portal for
OAuth clients, built on top of the contributed **Consumers** module. It gives
registered OAuth consumers — for example a decoupled front end or a third-party
application — a consistent surface for account-related flows, tying Drupal accounts
to the consumers that are allowed to act on them.

Because it sits in the OAuth / consumer path, treat its endpoints as
**authentication-adjacent**. In practice that means: register consumers
deliberately rather than leaving them open, keep each consumer's client secret in
environment variables or a Key entity (never in code or exported config), and review
which redirect targets and scopes each consumer is permitted. Those are the habits
that keep an OAuth surface safe.

It requires the `consumers` contributed module and targets Drupal 10.3 and 11. It
provides its own permissions, which you grant to the roles that should administer
the portal.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer
   (Consumers is required) and enable it.

## How to use it

Account Portal works alongside your OAuth / Consumers setup. After installing it,
manage your OAuth **consumers** (through the Consumers module) and grant Account
Portal's permissions to the roles that should administer the portal. Register each
consumer deliberately, keep its secret out of code and config, and audit the
redirect targets and scopes it is allowed before trusting it.
