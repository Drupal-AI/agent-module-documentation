# Social Auth Humanitarian ID — manual setup guide

**Social Auth Humanitarian ID** (`social_auth_hid`) lets users log in to your
Drupal site with their **Humanitarian ID (HID)** account. Humanitarian ID was a
sign‑in service provided to the humanitarian community by UN OCHA, and this module
added it as an OAuth2 login and registration provider through the **Social Auth**
and **Social API** framework.

> **Important:** the Humanitarian ID service was **decommissioned as of 31 January
> 2026**, and this module is **obsolete and unsupported**. With the identity
> provider gone, HID login can no longer work, so there is no reason to install
> this on a new site. This page is kept for reference and for anyone maintaining an
> older site that still has it enabled.

Technically the module is a thin **Social Auth network plugin**: it supplied the
HID client, endpoints, and user‑info mapping, while the OAuth flow — including the
`state` CSRF check and the token exchange — was handled by the Social Auth
framework's own controller rather than custom code here. It depends on the **Social
Auth** module and has no submodules. It has no access‑control role of its own
beyond authentication.

If you were configuring it while the service still existed, you would register an
HID application, store the **client ID and secret** as secrets (served over
HTTPS), enter them on the HID network settings within the Social Auth framework,
and review Social Auth's account‑linking settings (auto‑registration and email
matching). None of that is actionable now that the provider has shut down.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — historical install/enable steps and a
   note on the service's decommissioning.

## How it was configured

HID was configured as a network under the **Social Auth** framework: you entered
the HID client ID and secret on its network settings form (gated by the Social Auth
authentication administration permission), and the framework handled the redirect,
callback, `state`/CSRF check, and token exchange. Because the underlying service is
now gone, the login flow cannot complete regardless of configuration.
