<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API Tester — manual setup guide

**API Tester** (`api_tester`) is a Postman-style REST API testing tool that lives
inside Drupal. It lets developers build, send and inspect REST requests — with
support for environments you can switch between — directly in the admin UI, which
is handy for testing the site's own APIs or external services during development
without reaching for a separate desktop tool.

Because it can send arbitrary requests, access is gated by two permissions: **`use
api tester`** to work with the tool, and **`administer api tester`** to administer
it. Keep both limited to trusted developers — a request builder that can call
internal and external endpoints is not something to expose broadly.

The module depends on Drupal core's **User** and **System** modules and supports
Drupal 10 and 11.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

## How to use it

Once enabled, and with the **`use api tester`** permission granted to your
developer role, API Tester gives you an in-Drupal interface where you build a
request (method, URL, headers, body), send it, and inspect the response — and you
can define and switch between environments so the same requests can target, say,
your local and staging endpoints. Grant **`administer api tester`** to whoever
should manage the tool's setup, and keep both permissions restricted to trusted
developers.
