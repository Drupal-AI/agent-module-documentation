# Adnuntius — manual setup guide

**Adnuntius** (`adnuntius`) integrates the [Adnuntius.com](https://adnuntius.com)
advertising platform into Drupal so you can display ads on your site. It provides
configurable **ad blocks**: you set up your Adnuntius account and ad units in the
module's settings, then place the ad blocks in whatever theme regions you want ads
to appear. It is aimed at sites that want to monetise with programmatic
advertising through Adnuntius.

The ads are delivered client-side: the module embeds Adnuntius's ad-delivery
JavaScript, which loads the actual ad units in the visitor's browser. That means
the usual third-party-advertising trade-offs apply, and they are worth planning
for up front — the ad scripts are external code you do not control, ad tracking
raises privacy / consent obligations (wire the ads to your consent tooling where
required), and the external script hosts may need allowing in your
Content-Security-Policy if you run one.

The module depends on core's **Block** and **Field** modules, provides its own
permissions, and supports a wide core range (`^9.1 || ^10 || ^11 || ^12`). Its
current release is a beta (`8.x-1.0-beta6`).

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — set your Adnuntius account and ad
   units, then place the ad blocks.

## Where it lives in the admin menu

The module's settings live at its `adnuntius.settings` configuration form, where
you enter your Adnuntius account / ad-unit details. The ad blocks themselves are
placed through Drupal's normal **Block layout** UI (**Structure → Block layout**).

## How to use it

Configure your Adnuntius account and ad units in the settings form, then go to
Block layout and place the module's ad block(s) into the regions where ads should
show. See [Configuration](configuration/index.md) for the details, including the
privacy and CSP points to handle before ads go live.
