# Hybrid Login — manual setup guide

**Hybrid Login** (`hybrid_login`) gives you a customizable block for the Drupal
login page that presents an **external login service — typically SAML — alongside
or instead of** the standard Drupal username/password form. It's the tidy way to
tell users "sign in with your organisation account here" while optionally keeping
(or hiding) the built‑in Drupal login.

It's important to understand what this module *is* and *is not*. Despite the name,
Hybrid Login **does not authenticate anyone**. It contains no credential handling
and never logs a user in. What it does is presentation and access control on the
login page: it renders a themed panel (title, description, logo, button text)
whose button links to a path you configure — such as `/saml/login` — and it can
hide Drupal's own username/password fields, the create‑account link, and the
password‑reset link. It can also deny access to the core `/user/register` and
`/user/password` routes when you've turned those options off.

The actual logging‑in is done by whatever external authentication module the
button points at — most commonly the **SAML Authentication** module, though it
can be pointed at others. Hybrid Login just builds the entry point and controls
which core login UI appears.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and place the block.
2. [Configuration](configuration/index.md) — the settings form, field by field.

## Where it lives in the admin menu

Its settings form sits at **Configuration → People → Login settings**
(`/admin/config/people/hybrid_login`), gated by the **Administer site
configuration** permission. The block it provides is placed from **Structure →
Block layout**.

## How to use it

The typical setup is three steps:

1. **Install and enable** Hybrid Login (and the external auth module, e.g. SAML
   Authentication, that will actually perform login).
2. **Place the "Hybrid Login" block** on the `/user/login` page via Block layout —
   the recommended spot is the **Content** region, above the main page content.
3. **Configure the settings form** — set the button path (e.g. `/saml/login`),
   the block title/description/logo, and which core login elements to hide.

Because the module only shows or hides UI and denies access to core routes, it
cannot itself be an authentication‑bypass vector — the real login security lives
entirely in the external auth module the button targets. It's recommended to
clear the cache after changing Hybrid Login settings.
