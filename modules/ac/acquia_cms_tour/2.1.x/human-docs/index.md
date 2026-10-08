# Acquia CMS Tour — manual setup guide

**Acquia CMS Tour** (`acquia_cms_tour`) provides a **guided setup page** for an
Acquia CMS site. Instead of hunting through Drupal's admin for each integration a
new site needs to configure, it gathers those steps onto one dashboard so a site
builder can walk down the list and connect the pieces from a single place.

It is part of the Acquia CMS distribution and is **configuration and glue** rather
than a feature of its own — it depends on **Acquia CMS Common**
(`acquia_cms_common`) and is designed to sit alongside the rest of the family. On
an Acquia CMS site it is exactly right; on an unrelated site it assumes the
distribution's structure is present.

Think of it as the onboarding checklist you run once when standing up a new site:
it reduces setup friction by centralising the "have you configured X yet?"
questions and pointing you at the right forms.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — the tour/dashboard page and how to
   work through it.

## Where it lives in the admin menu

Once enabled, the tour dashboard appears in the **Acquia CMS** area of the admin.
Open it from the admin toolbar's Acquia CMS section and you land on the setup
page. See [Configuration](configuration/index.md) for what it contains.

## How to use it

Enable the module on an Acquia CMS site, open the tour dashboard, and step through
the onboarding items it lists — each points you to the setting or integration it
covers. It is most useful right after install; once the site is configured you
rarely need to return to it.
