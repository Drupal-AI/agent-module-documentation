# GSearch (Dataforsyningen) — manual setup guide

**GSearch (Dataforsyningen)** (`gsearch`) adds proper Danish address support to
Drupal, backed by the official Dataforsyningen **GSearch** API. Instead of
letting editors type an address free‑hand — and end up with a hundred spellings
of the same street — it provides an address **field type** whose widget
autocompletes against Denmark's national address register. The editor types a
street name or postcode, picks a suggestion, and the field stores a normalised
address complete with postal code, postal name, and latitude/longitude.

This is aimed at Danish sites that need correct, geocodable, structured
addresses — branches, events, contacts, deliveries — without manual data entry.
It is also positioned as the successor to the older DAWA‑based `address_dawa`
module, since the DAWA service is scheduled to shut down in July 2026.

The picker is built on the **Select2** module for a searchable dropdown. Each
field can optionally allow free‑text entry, so an editor can still store an
international or informal address that the register does not recognise.

A note on how the API is reached: the widget's autocomplete endpoints are
available to anyone who can load a form on the site (they are gated by the
"access content" permission, which is anonymous on a typical site). That is by
design — the widget has to work for whoever fills in the form — but it means the
site's Dataforsyningen quota is reachable by any site visitor. If your API access
is rate‑limited or billed, treat those endpoints as an abuse surface. And per
this project's conventions, the API token belongs in an environment variable, not
in exported configuration — see [Configuration](configuration/index.md).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the
   Select2 dependency) and enable the module.
2. [Configuration](configuration/index.md) — set your Dataforsyningen token, add
   the address field, and choose per‑field options.

## Where it lives in the admin menu

The module's own settings form is at **Configuration → GSearch → Configuration**
(`/admin/config/gsearch/config`), gated by **Administer site configuration**.
Address fields themselves are added per entity through **Structure → Content
types → *(type)* → Manage fields**, as with any Drupal field.
