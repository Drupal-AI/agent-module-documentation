# Social Auth Modal — manual setup guide

**Social Auth Modal** (`social_auth_modal`) changes *how* social login looks:
instead of sending a visitor away on a full-page redirect to sign in with a social
provider, it opens the provider's authentication page in a **modal pop-up window**.
When the visitor finishes authenticating, the modal closes automatically and the
current page reloads so their new logged-in session takes effect — they never lose
their place on the page they started from.

It is a thin **UX wrapper** around the Social Auth framework. It does not implement
any OAuth logic of its own: the real login flow — the provider redirect, the
`state` CSRF check and the token exchange — is still handled by **Social Auth** and
whichever provider plugin you use (Google, Facebook, Microsoft and so on). This
module only swaps the presentation from full-page to modal. It depends on the
**Social Auth** module (`social_auth`) and has no submodules.

Because it only changes presentation, its security rests entirely on the
underlying Social Auth provider being configured correctly — credentials stored as
secrets, HTTPS in use. There is nothing to configure on this module itself; it
works as soon as it is enabled alongside at least one working Social Auth provider.
Note the version pairing: the 2.x line of this module works with the 4.x line of
Social Auth (the 1.x line paired with Social Auth 3.1.x).

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside Social Auth.

## How to use it

There is no settings form. Once the module is enabled and you have at least one
configured Social Auth provider, the social login buttons in the Social Auth login
block open their authentication window as a modal instead of redirecting the whole
page. Configure your providers as normal through Social Auth — this module simply
changes how those existing buttons behave.
