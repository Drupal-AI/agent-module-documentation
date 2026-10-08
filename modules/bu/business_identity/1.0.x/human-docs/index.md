# Business Identity — manual setup guide

**Business Identity** (`business_identity`) gives your site one central place to
store your organisation's identity: its name, logo, contact details, and legal
details. Instead of retyping the company name in a footer, the contact address on
one page, and the legal registration in another, you record these once and reuse
them across the site — in footers, metadata, structured data, and anywhere else
that should reflect the same source of truth.

The information is admin-managed configuration. It depends only on Drupal core's
System and Config modules, provides its own permission for who may edit the
identity, and targets Drupal 11 and 12.

Business Identity is a site-building and administration feature. Beyond its own
edit permission it has no access-control role, and it stores organisational
details rather than user content.

This guide is written for a **human** clicking through the admin UI. If you want
a terse, token-cheap reference for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enter your organisation's identity
   details.

## Where it lives in the admin menu

Business Identity stores its data as site configuration and is edited from a form
in the admin **Configuration** area, behind its own permission. Grant that
permission under **People → Permissions** (`/admin/people/permissions`) to the
roles that should maintain the organisation's details.
