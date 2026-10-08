# Conzent CMP — manual setup guide

**Conzent CMP** (`conzent_drupal`) embeds the **Conzent** consent‑management
platform into your Drupal site: a GDPR, CCPA, and ePrivacy‑compliant cookie‑consent
banner that is IAB TCF v2.2 and Google CMP certified (CMP #446). It presents the
banner and preference center, blocks cookies automatically, auto‑translates into
30+ languages, and can wire consent into **Google Consent Mode v2** and **Google
Tag Manager** so your marketing tags only fire once the visitor has agreed.

You can run it against **Conzent Cloud** (nothing to host) or point it at a
**self‑hosted (OCI)** deployment. Either way the module does not do anything until
you configure it: at minimum you paste your **Website Key** from the Conzent
dashboard. The module then injects the Conzent CMP script so the banner loads on
the front end, and — if you supply a GTM container id — feeds the consent state
into GTM's data layer.

Because the CMP is a **third‑party script loaded on every page**, that origin (your
Conzent Cloud or self‑hosted server) is added to every response; account for it in
any Content‑Security‑Policy you run. The Website Key is an account identifier
(configuration), not a secret. Administration is gated by the core **Administer
site configuration** permission, with an additional **`administer conzent`**
permission also provided.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — paste your website key, choose cloud
   vs self‑hosted, and optionally add GTM.

## Where it lives in the admin menu

Once enabled, configure the module at **Configuration → System → Conzent CMP**
(`/admin/config/system/conzent`).
