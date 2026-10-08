# Smartsheet — manual setup guide

**Smartsheet** (`smartsheet`) connects your Drupal site to
[Smartsheet](https://www.smartsheet.com/), the work- and spreadsheet-management
SaaS, through its REST API. It gives developers a simple service for talking to the
Smartsheet API — reading and writing sheets and rows — and can also push data
submitted through a Drupal form straight into a Smartsheet sheet as a new row.

The problem it solves is the plumbing of the integration. Rather than hand-rolling
authenticated HTTP calls to Smartsheet, you configure an access token once and use
the module's `smartsheet.client` service, which exposes `get()`, `post()`, `put()`,
and `delete()` methods that map onto the corresponding REST verbs. Options are
passed through to the underlying Guzzle request, so you can add query strings and
other request settings as needed.

For forms, the module offers a lightweight "submit to Smartsheet" capability: you
add a couple of properties to a Form API form (`#smartsheet_sheet_id` and
`#smartsheet_column_mapping`, an array mapping form field names to sheet column
titles or IDs) and each matching submitted value is written into the mapped column
of a new sheet row.

Using the API productively requires a bit of PHP — this is a developer integration
module rather than a point-and-click feature. It provides its own permission and
runs on Drupal 9, 10, and 11. The current 3.x line targets Smartsheet's 2.0 API.

A valid **Smartsheet access token** is required for the module to work at all. Keep
it out of plain configuration — store it in an environment variable and reference it
securely rather than committing it.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — generate a Smartsheet access token and
   tell Drupal about it.

## Where it lives in the admin menu

The module's settings form is at **Administration → Configuration → Web services →
Smartsheet API** (`/admin/config/services/smartsheet`), where you enter the access
token. (You can also set the token in `settings.php` instead — see
[Configuration](configuration/index.md).)
