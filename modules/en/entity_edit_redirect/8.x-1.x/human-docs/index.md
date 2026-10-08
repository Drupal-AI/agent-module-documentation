# Entity Edit Redirect — manual setup guide

**Entity Edit Redirect** (`entity_edit_redirect`) intercepts Drupal's normal
entity edit-form routes and sends the editor to a matching page on a **configured
external editing server** instead. Viewing content stays on your Drupal site; the
moment someone opens an edit form, they're 301-redirected to your central editor.

This is aimed at distributed / decoupled setups. If you publish content from one
main instance (a "contentpool") out to secondary sites ("satellites") and want
all editing to happen back on the main instance, this module funnels every edit
click to the right place. You configure a base URL for the external editor and a
list of path patterns per entity type — or per bundle, so Articles and Pages can
go to different editing screens if you like. Patterns can include `{uuid}`, which
is replaced with the entity's UUID so the external editor knows what to open.

It works via a response event subscriber: for any route named
`entity.{entity_type}.edit_form` that matches one of your patterns, it issues a
`TrustedRedirectResponse`. Optionally it appends the Drupal return URL as a
`destination` query parameter (from `?destination=`, a same-origin referer, the
entity's canonical URL, or the site base URL) so the external editor can send the
person back where they came from. The redirect host is always the admin-set base
URL — never request-controlled — and Drupal's trusted-redirect mechanism is used,
so this is not an open redirect.

There is nothing to switch on beyond configuration: until you set a base redirect
URL and at least one path pattern, no redirects happen. It has no module
dependencies.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the settings form, field by field:
   base URL, destination handling, and the per-type/per-bundle path patterns.

## Where it lives in the admin menu

The settings form is at **Configuration → Content authoring → Entity Edit
Redirect** (`/admin/config/content/entity_edit_redirect`). Access is gated by the
module's own permission — note the maintainers' typo, *"admininister entity edit
redirect configuration"* — so grant that permission to whoever manages the
redirect rules.
