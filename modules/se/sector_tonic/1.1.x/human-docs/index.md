# Sector Tonic — manual setup guide

**Sector Tonic** (`sector_tonic`) is a small convenience module that polishes the
admin and content-editor experience for sites built on the **Sector** distribution.
Its name is a play on its purpose: it is "the perfect mixer to go with your Gin" —
it sits on top of the Gin admin theme and its toolbar to give editors and
administrators a cleaner, more refined back-end.

In this first release the module is essentially a Composer-and-install wrapper: when
you enable it, it sets **Gin** as the admin theme and pulls in the companion pieces
that make Gin pleasant to use — **Gin Toolbar** (its declared dependency,
`gin_toolbar`) and, where present, **Gin Login**. There is nothing you have to
configure by hand; the improvements apply as soon as the module is on. It is purely
an administration/UI enhancement — it adds no content types, no permissions of its
own, and has no role in access control.

Sector Tonic is intended for use as part of the Sector distribution, but it can be
enabled on any Drupal 10 or 11 site that wants the same Gin-based editorial polish,
as long as the Gin theme and Gin Toolbar are available.

This guide is written for a **human** setting the module up through Composer and the
admin UI. If you are an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead — they are terser and token-cheap.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (it works with no further configuration).

## How to use it

There is nothing to switch on beyond enabling the module. Once it is active, log in
and open any admin page: the Gin admin theme and its toolbar are in place, and the
editing screens carry Sector Tonic's refinements automatically. Because it depends on
`gin_toolbar`, Drupal will enable that companion module for you when you turn Sector
Tonic on.
