# Taxonomy Views Integrator — manual setup guide

**Taxonomy Views Integrator** (`tvi`) lets you replace the default taxonomy
term‑listing page with a **View** of your choosing — set per individual term, per
vocabulary, or globally. Since Drupal 8 the term page at `/taxonomy/term/{tid}` is
rendered by a core View, but core gives you no way to point *different* terms or
vocabularies at *different* Views. TVI fills that gap.

For example, you can show a calendar View on every term page of an "Events"
vocabulary while leaving other vocabularies on the default listing, give one featured
category its own custom View, or set a single site‑wide default for all term pages. TVI
passes the term ID to the chosen View as a contextual argument (and optionally all
trailing URL arguments), so your View can filter correctly, and it keeps modules like
Search API and Facets working by making sure the active View is correctly detected.

Assignment happens right where you'd expect: a settings fieldset is injected into the
**term edit form** and the **vocabulary edit form**, plus a **global** default on TVI's
own settings form. When more than one applies, TVI resolves them by precedence — a
per‑term override wins, then an inheriting vocabulary or parent‑term override, then the
global override, then core's default (unless you've disabled it). It depends on core's
**Views** and **Taxonomy** modules, and its permissions are per‑vocabulary so you can
delegate who may set the View for which vocabulary or terms.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable
   it.
2. [Configuration](configuration/index.md) — assign a View per term, per vocabulary, or
   globally, and understand the precedence order.

## Where it lives in the admin menu

- **Global settings** — **Configuration → User interface → Taxonomy Views Integrator**
  (`/admin/config/user-interface/tvi`), gated by the **Administer taxonomy views
  integrator** permission.
- **Per vocabulary** — a *Taxonomy Views Integrator* fieldset on each vocabulary's edit
  form (**Structure → Taxonomy → *(vocabulary)* → Edit**).
- **Per term** — a *Taxonomy Views Integrator* fieldset on each term's edit form.

The per‑vocabulary and per‑term fieldsets only appear to users who hold the matching
per‑vocabulary permission.
