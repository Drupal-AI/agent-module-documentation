# Group SSO — manual setup guide

**Group SSO** (`gsso`) bridges the gap between an external identity provider and
Drupal's own authorization model. When people sign in through single sign‑on
(currently SAML, via SimpleSAMLphp), the IdP typically sends along attributes
describing which groups and roles the person belongs to. Group SSO reads those
attributes on each login and translates them into Drupal **roles**, **Group**
memberships, and **group roles** — so the IdP administrators effectively control
who can do what on your Drupal site.

It is important to understand what this module does *not* do: it does **not**
perform authentication itself. It hooks into SimpleSAMLphp's already‑verified
login flow, so the SAML assertion signing and the CSRF/state protection are
SimpleSAMLphp's responsibility, not Group SSO's. Group SSO only runs *after* the
person is authenticated, to map their claims onto Drupal authorization.

The mapping is driven by a matrix you configure: for each value that can appear in
the IdP's group/role attributes, you say which Drupal roles to grant and which
Groups (and group roles) to join. Two attributes are read — one carrying group
information, one carrying role information — and each can be split on a separator
for multi‑value claims.

A behaviour to be deliberate about: **every login re‑derives authorization from
the IdP**. When a user's claims change, Group SSO first strips *all* of their
roles and Group memberships and then re‑adds only the mapped ones. That makes your
mapping configuration the single source of truth — anything not covered by the
mapping is removed. A misconfiguration can therefore silently revoke access, so
plan the matrix carefully.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (it requires Group, and SimpleSAMLphp Authentication for the actual
   login).
2. [Configuration](configuration/index.md) — set the SSO type, attribute names,
   separator, and the claim‑to‑role/group matrix.

## Where it lives in the admin menu

The settings form is at **`/admin/group/sso`**, gated by the **Administer group**
permission.
