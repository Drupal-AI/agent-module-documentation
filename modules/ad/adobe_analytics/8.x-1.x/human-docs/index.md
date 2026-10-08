# Adobe Analytics — manual setup guide

**Adobe Analytics** (`adobe_analytics`) adds Adobe Analytics — the product
formerly known as Omniture — tracking to your Drupal site. When configured, it
injects the Adobe Analytics / AppMeasurement JavaScript snippet into your pages so
that page views and events are recorded in your Adobe Analytics report suite. It
is the standard way to wire a Drupal site up to Adobe's analytics platform without
hand-editing your theme's templates.

You supply your Adobe Analytics tracking details (your report suite / account
configuration) in the module's settings, and it takes care of emitting the
tracking code on the front end. The module provides its own permissions so you can
control who may change the tracking configuration, and it targets Drupal 10 and 11.

Because this loads a **third-party tracking script** that collects visitor
analytics and sends the data to Adobe, treat it as a privacy-relevant integration:
disclose it in your privacy policy and integrate it with your consent tooling where
required — analytics is frequently consent-gated under regulations such as GDPR.
Beyond its permission, it has no content or access-control role.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enter your Adobe Analytics tracking
   details and control who may edit them.

## Where it lives in the admin menu

The module provides a settings form where you enter your Adobe Analytics report
suite / tracking configuration, and a permission (on **People → Permissions**)
that governs who may change it.

## How to use it

Enter your Adobe Analytics tracking details in the settings form and save; from
then on the tracking snippet is emitted on your pages and data flows to Adobe.
Handle the privacy and consent obligations described in
[Configuration](configuration/index.md) before you go live.
