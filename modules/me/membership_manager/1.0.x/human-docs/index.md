# Membership Manager — manual setup guide

**Membership Manager** (`membership_manager`) gives Drupal a flexible system
for running memberships and subscriptions — plans, joining, renewal, and
expiry — without tying you to any particular billing system. You define
membership *plans* (free, paid, or trial) as configuration, and each user's
membership is a content entity with a full lifecycle: pending, trial, active,
expired, or canceled. It handles time-based expiration with configurable grace
periods, processes expiries on cron, and can synchronise Drupal roles as a
membership activates or lapses.

The problem it solves is the busywork and fragility of hand-rolling access
tiers. Instead of scattering "is this user a member?" logic across your site,
you protect any route by adding a `_membership_active` requirement, and you can
scope access to a named feature/entitlement per plan. Access decisions are
cacheable and respect Drupal's cache contexts. It works equally well for free
and paid memberships, SaaS account plans, membership portals, and
feature-gated content.

Membership Manager is deliberately **payment-agnostic** — it has no hard
dependency on Drupal Commerce, Stripe, or any billing system. Its only
dependency is core's **User** module. When money changes hands elsewhere (a
Commerce order, a Stripe webhook, a custom SaaS backend), you call the module's
service to assign or renew a membership. It also emits lifecycle events
(activated, expired, canceled, renewed) that other modules — ECA, Rules, or your
own code — can react to.

The module does not work entirely "on enable": you need to create at least one
plan and grant the right permissions before memberships mean anything. Setup is
covered below.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and confirm it is ready.
2. [Configuration](configuration/index.md) — create membership plans, understand
   the permissions, and protect routes by membership.

## Where it lives in the admin menu

The module does not register a single "settings" page. Its administrative home
is the membership area at **`/admin/membership`**, where you create and manage
plans. After enabling the module, visit that page to create your first plan.
