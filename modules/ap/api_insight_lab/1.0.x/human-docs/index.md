<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API Insight Lab — manual setup guide

**API Insight Lab** (`api_insight_lab`) is an API testing suite that runs inside
Drupal. Beyond sending individual requests, it supports **load testing** and
**request chaining** (feeding the result of one request into the next) and other
advanced testing features, so developers can test and profile REST APIs — the
site's own or external ones — without leaving the site.

Use it during development to exercise and profile endpoints, run load tests, and
build multi-step request flows. Because it can send arbitrary requests — including
load tests that generate a lot of traffic — restrict access to trusted
developers, and be aware that it can reach both external and internal endpoints.
The module provides its own permission for that reason.

It depends on Drupal core's **REST** module and supports Drupal 10 and 11.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it requires
   core's REST module) and enable it.

## How to use it

Once enabled, and with its permission granted to your developer role, API Insight
Lab gives you an in-Drupal interface to build and send requests, chain them
together, and run load tests against an endpoint, then inspect the results and
timing. Keep the permission limited to trusted developers — the tool can issue
arbitrary requests, including load tests and calls to internal endpoints, so it is
not something to expose broadly.
