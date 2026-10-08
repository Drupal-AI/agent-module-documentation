# Tarte au citron AddToAny — manual setup guide

**Tarte au citron AddToAny** (`tarte_au_citron_addtoany`) is a small bridge between
two other modules: the **Tarte au citron** cookie-consent manager and the
**AddToAny** social-sharing buttons. On its own, AddToAny loads its third-party
sharing script as soon as a page renders. This module holds that back — the
AddToAny buttons and their script only load *after* the visitor has granted the
matching Tarte au citron consent, which is what GDPR-style consent rules require.

It depends on both the **Tarte au citron** and **AddToAny** modules and sits in the
GDPR package. It adds no settings, routes, or permissions of its own — its whole
job is to make AddToAny consent-aware. Because of that, it starts doing its work as
soon as it is enabled; the consent orchestration and any service configuration live
in the parent Tarte au citron module.

This is a privacy/compliance feature, not an access-control one: it defers loading
the third-party AddToAny script until consent is given, and does nothing else.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and its Tarte au citron and AddToAny dependencies.

## How to use it

Enable the module with AddToAny and Tarte au citron already in place, then manage
the consent behavior from Tarte au citron itself — this bridge simply ensures the
AddToAny buttons wait for consent. There is nothing to configure on the module
directly; visit the Tarte au citron services configuration to control how the
consent banner presents the sharing service.
