<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SAML Auth Multi IdP — agent index

Adds **multiple-identity-provider (IdP) support to the SAML Authentication (samlauth) module** (SSO against
several IdPs). Depends on `samlauth`. Provides permissions. Version **1.0.1-alpha3**. Core `^10||^11`.

Auth — assertion validation (signatures/conditions) handled by **samlauth**; this adds per-IdP config/routing.
Keep each IdP's cert/metadata correct, validate per IdP, store signing keys securely, HTTPS.
