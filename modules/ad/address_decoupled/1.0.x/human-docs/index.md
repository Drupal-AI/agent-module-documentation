# Address Decoupled — manual setup guide

**Address Decoupled** (`address_decoupled`) exposes the **Address** module's data
and behaviour over **REST**, so a decoupled (headless) front end — React, Next.js,
or similar — can render and validate addresses correctly without relying on
Drupal's own address forms. The tricky part of addresses is that each country has
its own format and its own list of states/provinces; this module makes that
country and subdivision metadata available over the API so your JavaScript front
end can build the right fields and check them the way Drupal would.

It's aimed at decoupled sites that collect or display addresses. It depends on
Drupal core's **Address** and **REST** modules, and ships an
`address_decoupled_commerce` submodule for sites using Drupal Commerce.

Because this is an API surface, the usual rule applies: **access-control the REST
resources it exposes** just as you would any other endpoint. Address format data
is not secret, but you still decide who can reach the endpoints and enable only
what your front end actually consumes.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (and the Commerce submodule if you need it).

## Where it lives in the admin menu

The module has no settings page of its own. Its REST resources are managed the same
way as any other, through core's REST configuration — commonly the **REST UI**
module (`/admin/config/services/rest`) if you have it installed — where you enable
each resource, choose formats, and set the authentication and permissions that
guard it.

## How to use it

1. Enable Address Decoupled (see [Installation](installation/index.md)), along with
   the `address_decoupled_commerce` submodule if your site uses Commerce.
2. Using core REST configuration (or the REST UI module), **enable the address REST
   resources** the module provides, and set their formats, authentication, and
   access permissions.
3. From your decoupled front end, call those endpoints to fetch country/subdivision
   metadata and address formats, and render or validate addresses client-side.
