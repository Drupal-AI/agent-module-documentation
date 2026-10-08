# Country Alter UI — manual setup guide

**Country Alter UI** (`country_alter_ui`) gives you an admin interface for
customizing the built‑in list of countries that Drupal offers in country and
address fields. Rather than editing code or writing a hook, you use a screen to
**enable, disable, or rename** countries — so your forms show only the countries
that are relevant to your site, with the names and codes you want.

The problem it solves is a familiar one for site builders working with address or
country fields: Drupal ships the full ISO country list, but many sites only ship to
a handful of countries, or need a country's display name adjusted. Country Alter UI
lets you tailor that list from the admin UI instead of overriding it in code.

It's a site‑building / localization tool. It affects only which country *options*
are presented and how they're labelled — it has no role in content or access
control. It works across a wide core range — Drupal 10.3, 11, and 12 — and has no
other module dependencies.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Once enabled, Country Alter UI adds an administration screen for altering the
country list. Look for it under the **Configuration** section of the admin menu
(the module description places it among administration/localization tools). From
there you can enable or disable individual countries and rename them.

## How to use it

1. Open the Country Alter UI screen from the admin menu.
2. **Enable or disable** countries so that your country and address fields present
   only the countries you want to offer.
3. **Rename** any country whose default label or code you want to change.
4. Save. Your country and address fields now reflect the customized list.
