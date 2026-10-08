# QR Code Fields — manual setup guide

**QR Code Fields** (`qrcode_fields`) adds a whole family of field types and
matching blocks that render a scannable QR code from your content. Instead of
generating QR images by hand, you add a field to a content type — or place a
block — and the module builds the QR code on the fly from the data you enter.

There are nine field types, one per kind of QR payload: **URL**, **Text**,
**Phone** (`TEL:`), **SMS** (`SMSTO:`), **Email**, **WiFi** (join-a-network
codes), **meCard**, **vCard v3** (contact cards) and **Calendar event**
(vCalendar). Each collects exactly the pieces that payload needs — for WiFi that's
the network name, password and encryption type; for a vCard it's name, phone and
email; and so on. Every text input supports **Token** replacement against the host
entity, so a QR value can be built dynamically from the entity's own fields — for
example a URL QR that always points at `[node:url]`.

The actual QR image is produced by an **external service** chosen per field or per
block. The default is **goQR** (`api.qrserver.com`); you can also pick **Tec-IT**
or the deprecated **Google Chart API**. Because the image is generated remotely,
the payload — including WiFi passwords or vCard contact details — is placed in the
request URL and fetched directly by the visitor's browser from that third party.
Keep that in mind before encoding anything sensitive; there is no built-in option
to self-host the generator (that would require a custom service plugin, described
in the agent docs).

The module depends on **Token**, plus core's **Block** and **Field** modules.
There is no global settings page — you configure everything per field or per
block.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no dedicated admin page. You work in the usual field and block places:

- **Manage fields / Manage form display / Manage display** on any content type,
  media type or other fieldable entity, to add and configure a QR field.
- **Structure → Block layout** (`/admin/structure/block`), to place one of the
  nine *QR Code Fields* blocks in a region.

## How to use it

**As a field on a content type:**

1. Go to the content type's **Manage fields** and click **Add field**.
2. Choose the QR field type that matches your payload (for example *QR Code — URL*
   or *QR Code — WiFi*).
3. On the field settings, pick the **QR generation service** (`qrcode_plugin`,
   default **goQR**). Under *Manage form display* the widget lets you set a default
   value and the QR image **width/height** (default 200×200) and shows a live
   preview while editing.
4. Fill in the field when creating content. Use tokens like `[node:title]` or
   `[site:url]` to build the value dynamically.

Two formatters control display: **`qrcode_fields_formatter`** renders the QR as an
image (and can optionally echo the encoded text), and
**`qrcode_fields_formatter_url`** treats the code as an actionable link with labels
such as "Send email" or "Add to contact".

**As a standalone block:**

Place any of the nine *QR Code Fields* blocks (category **QR Code Fields**) in a
region via Block layout. Each block form collects the same data as its field, plus
the service choice, image dimensions and an optional "display text" toggle, and
supports tokens too.
