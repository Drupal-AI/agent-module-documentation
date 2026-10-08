# SharpSpring — manual setup guide

**SharpSpring** (`sharpspring`) adds the SharpSpring marketing-automation tracking
JavaScript to every page of your site. Once configured with your SharpSpring
account, visitor activity is tracked in SharpSpring so you can generate sales leads
and run marketing automation against real on-site behavior.

The module is configured on its own settings form (route `sharpspring.settings`),
where you supply your SharpSpring account / tracking details. It provides its own
permission to control who may configure it, and it sits in the SharpSpring package.
It supports Drupal 10.2 and 11 and has no other module dependencies or submodules.

Because SharpSpring is a third-party marketing tracker, treat it as a
privacy/consent matter. It loads external JavaScript that tracks your visitors, so
you should disclose it in your privacy policy and gate it behind cookie/consent
management (for GDPR, CCPA, and similar requirements) where that applies. Beyond the
permission that controls who configures it, the module has no access-control role.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enter your SharpSpring account and turn
   tracking on.

## Where it lives in the admin menu

The module adds a **SharpSpring** settings form (route `sharpspring.settings`),
reached from its link in the site's Configuration area. See
[Configuration](configuration/index.md) for what to enter.

## How to use it

Once you have entered your SharpSpring account details on the settings form, the
tracking JavaScript is added to every page automatically, and visits start showing
up in your SharpSpring account. Remember to disclose the tracking and honor visitor
consent.
