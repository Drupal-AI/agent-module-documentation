# DocCheck Basic — manual setup guide

**DocCheck Basic** (`doccheck_basic`) adds a **DocCheck login** to your Drupal
site. DocCheck is an external authentication service that verifies a visitor is a
registered medical professional — the kind of gate pharmaceutical and medical
sites are often *required* to put in front of healthcare-professional-only content,
because in many markets that verification is a regulatory obligation.

The module provides two things: a **login page** at `/doccheck-login` and a
**DocCheck Basic block** you can place in a region. Both surface the DocCheck login
mechanism (using DocCheck's *basic* license from
[access.doccheck.com](https://access.doccheck.com/)) so a visitor can authenticate
as a verified professional. It depends on core's **Node** and **Block** modules.

An important scope note, straight from the module itself: DocCheck Basic **only
adds a login mechanism for one user**. It does **not** set any permissions and does
**not** block access to content on its own. In other words, enabling this module
gives you the DocCheck login surface, but *gating* your HCP-only content is
something you still have to arrange with Drupal's own access controls — confirm the
protected content is genuinely access-controlled, not merely hidden. Treat your
DocCheck credentials/keys as secrets, and serve the site over HTTPS. The module's
`README.txt` carries the fuller setup details.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

This module does not expose a central Drupal settings form in its packaged docs;
its DocCheck account/credential details are described in the module's `README.txt`.
Its user-facing surface is the login page and block described below.

## Where it lives in the admin menu

DocCheck Basic does not add its own settings page to the admin menu. Its two
surfaces are:

- **Login page** — visit `/doccheck-login` to see the DocCheck login.
- **DocCheck Basic block** — place it from **Structure → Block layout** into any
  theme region where you want the DocCheck login to appear.

## How to use it

1. Set up your DocCheck account and obtain the basic-license credentials from
   [access.doccheck.com](https://access.doccheck.com/), following the module's
   `README.txt` for the exact values to supply. Keep these credentials secret.
2. Place the **DocCheck Basic** block via **Structure → Block layout**, and/or
   direct professionals to the `/doccheck-login` page.
3. Because the module only provides the login and does not restrict content by
   itself, use Drupal's own access controls (permissions, published/unpublished
   state, or a dedicated access module) to actually gate your HCP-only content, and
   verify that gate works before going live.
