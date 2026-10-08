# Drupal.org — manual setup guide

**Drupal.org** (`drupalorg`) is the module that bundles the site-specific
customizations powering the drupal.org website itself. It wires together core's
JSON:API and the JSON:API Views module to expose project, user, and contribution
data, and it adds bespoke behaviors — such as security-release management —
tailored to how drupal.org operates.

Be clear about the audience before you install it: this module is **not meant to
be generally useful on other sites**. It is published as contrib mainly for
transparency and as an educational example of the kinds of modifications you can
make with a site-specific module. The permissions it defines (for example
`manage security releases`) reflect drupal.org's own role and workflow model, so
on a general site they are only meaningful if you have replicated that same
model.

It depends on core's **Block** and **JSON:API** modules and on the contributed
**JSON:API Views** module, and it supports Drupal 9, 10, and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its JSON:API dependencies.

There is **no general configuration page** for this module — its behavior is
site-specific to drupal.org rather than a set of options you tune.

## How to use it

Because this module encodes drupal.org's own customizations, most sites will only
ever install it to read the code and learn from it. If you do enable it, the
JSON:API and JSON:API Views integrations it sets up become available through the
usual JSON:API routes, and its workflow permissions appear on the standard
**People → Permissions** page, where you can grant them to roles that match your
own model.
