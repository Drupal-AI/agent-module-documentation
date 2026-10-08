<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API Data Connector — manual setup guide

**API Data Connector** (`api_data_connector`) lets Drupal fields autocomplete and
populate their values from an external API. Instead of typing a value by hand or
choosing from a fixed list, an editor filling in a field gets live suggestions
pulled from a remote API, presented through a **Select2** autocomplete widget — so
they can pick from up-to-date remote data as they edit.

Use it when a field's allowed values really live in another system (a product
catalog, a directory, a third-party service) and you want editors to select from
that source rather than duplicating it in Drupal. The API endpoint and any
credentials it needs should be stored securely — prefer environment variables over
values committed to exported configuration.

The module depends on the **Select2** module (which provides the autocomplete
widget) and requires **Drupal 11**. It provides its own permission. This is an
early-stage (alpha) project, so its documentation is thin — the notes here
describe what it does; check the project page for the current configuration
specifics.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it requires the
   Select2 module) and enable it.

## How to use it

Once the module and Select2 are enabled, the connector is applied at the **field**
level: you configure a field to use the API-backed Select2 autocomplete and point
it at the external API that supplies the suggestions. Editors then get live remote
suggestions when they fill in that field. Because the exact field/widget settings
are what drive this, review your field's form-display configuration after
enabling, and keep the API credentials in a secure store (environment variables)
rather than in exported config.
