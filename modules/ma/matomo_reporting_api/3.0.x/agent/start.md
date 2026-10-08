<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Matomo Reporting API (matomo_reporting_api) — agent index

Client to fetch reports from a **Matomo Reporting API** for display in Drupal. Version **3.0.1**.
Core `>=8`. Submodule `matomo_reporting_api_example`. Needs a Matomo instance + API auth token.

Integration library (provides the API client; displays are built on top). **The Matomo auth token
is a credential** granting read access to analytics — store it via a Key entity/env, not plain
config/git.