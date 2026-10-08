# Advertising — manual setup guide

**Advertising** (`ad`) is a flexible, extensible system for running adverts on a
Drupal site. It is deliberately more than a place to paste an ad-network snippet:
it models ads as **entities** that you define, target to sections or audiences,
place into slots, rotate, and — for ads you *sell* rather than buy from a network
— count and report on. If all you need is a single network script in a region,
this module is heavier than the job; its value is in managing a real advertising
operation.

Worth stating plainly: the release documented here is **11.0.0-alpha12**. The
version number tracks Drupal core, not the module's own maturity — this is an
alpha, so evaluate it carefully before using it in production. It runs on Drupal
10 and 11.

Three concerns come with any advertising deployment, and none of them is this
module's job to solve:

- **Consent.** Ad-network scripts are third-party code that can modify the page
  and set tracking cookies. On an EU-facing site they need consent gating — see
  modules such as `usercentrics` and `consent_mode`. Installing an ad module
  doesn't change that obligation.
- **Performance.** Ads are usually the biggest performance cost on a content
  site: third-party scripts, synchronous loads, and layout shift as slots fill.
  If Core Web Vitals matter to you, the ad implementation is where the budget
  goes.
- **Data integrity.** Where ads are *sold*, impression and click counts become
  commercial data that someone is invoiced against — so their accuracy and who
  can read the reports are business concerns, not just analytics.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

Because Advertising models ads as entities, using it is a site-building exercise:
you define your adverts, decide where they should appear (slots/placement), set
any targeting and rotation, and — for sold ads — review the impression and click
reporting. Pair it with a consent-management module before any network scripts go
live on a site with EU visitors, and budget for the performance impact of the ad
scripts you load. Given the alpha status, prove your setup on a non-production
environment first.
