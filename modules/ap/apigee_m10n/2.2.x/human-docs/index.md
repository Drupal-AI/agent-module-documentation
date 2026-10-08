# Apigee Monetization — manual setup guide

**Apigee Monetization** (`apigee_m10n`) brings Apigee's API **monetization** into a
Drupal developer portal: rate plans, prepaid balances and developer purchases for
API products. When an organisation sells access to its APIs, this is the half of
the portal where the transaction happens — a developer browses API products, picks
a rate plan, tops up a balance and sees their usage. Apigee does the metering and
billing; Drupal, through the Apigee Edge module family, is the storefront. This
module adds the monetization layer on top of **Apigee Edge**.

> **Compatibility warning — read before installing.** This release **cannot be
> installed on Drupal 11.4**, and this was verified in practice. Its dependency
> `apigee_edge` 4.1.0 injects the container parameter `%main_content_renderers%`
> into two event subscribers, but Drupal 11.4 core **no longer defines that
> parameter**. The result is a hard container-build failure
> (`DefinitionErrorExceptionPass: You have requested a non-existent parameter
> "main_content_renderers"`) that takes down both the site and Drush. Worse,
> because it fires *during module installation*, it can leave other modules
> half-installed — on the test site it fataled mid-batch and left 80 of 120
> modules in a broken "enabled but never installed" state, recoverable only by
> restoring the database.
>
> **Before planning an Apigee monetization portal on Drupal 11, check that
> `apigee_edge` has a release compatible with the exact core version you are on.**
> The upstream fix is for Apigee Edge to resolve the renderers from tagged services
> (or inject a service) instead of the removed parameter.

This guide is written for a **human** evaluating or setting the module up. If you
want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — requirements and the compatibility
   caveat you must clear first.

## How to use it

Once you are on a compatible core/Apigee Edge combination and the module installs
cleanly, it plugs monetization into the existing Apigee Edge developer portal:
developers browse API products, choose rate plans, manage prepaid balances and
view their usage, with Apigee handling the billing behind the scenes. All of the
Apigee connection and credential handling is inherited from Apigee Edge — configure
that module (connection, Key-backed credentials, permissions) as described in its
own guide first.
