# SynCabinet — manual setup guide

**SynCabinet** (`syncabinet`) is a **vendor-specific "profile and auth" module**
from the SynapseF suite. It handles user profile/account and authentication flows
in that vendor's context, and it is built to work alongside its companion cart
module — it depends on [`syncart`](https://www.drupal.org/project/syncart).

Because it is part of a supplier's stack rather than a general-purpose module,
its behaviour is tailored to that context and its public documentation is
minimal. It belongs to a specific SynapseF/syncart deployment and is intended to
be used only within that stack.

Two things are worth stressing. First, this is an **authentication and profile**
module, and auth code always warrants scrutiny — before you rely on it, **review
its actual behaviour in your context**: how it handles credentials, how it manages
sessions, and what any account-creation or registration paths do. Second, it does
not document a general-purpose access-control contract here, so do not assume it
enforces access in a particular way — verify it. For configuration specifics,
consult the vendor's own documentation. It supports Drupal 8.8, 9, 10 and 11, and
is currently marked *not covered* by Drupal's security advisory policy.

This guide is written for a **human**. If you want terse, token-cheap references
for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, alongside its
   `syncart` dependency, and enable the module.

## How to use it

SynCabinet is meant to be used only within the SynapseF/syncart stack it belongs
to, so its profile and authentication behaviour surfaces as part of that suite
rather than as a standalone feature. There is no general settings page documented
here — refer to the vendor's documentation for how to configure it in your
deployment, and review what it does in context before relying on it.
