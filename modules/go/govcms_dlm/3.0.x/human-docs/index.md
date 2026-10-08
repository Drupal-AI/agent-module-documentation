# GovCMS DLM — manual setup guide

**GovCMS DLM** (`govcms_dlm`) adds an optional **Dissemination Limiting Marker**
(DLM) — an Australian-government protective marking such as `[SEC=OFFICIAL]` or
`[SEC=UNOFFICIAL]` — to the emails your Drupal site sends. Once configured, the
marking is appended to the subject line of outgoing mail that goes through
Drupal's mail system, so that automated messages (workflow notifications, webform
confirmations, account emails and the like) carry the security classification
label that Australian Government systems are expected to apply.

The reason this matters is practical as well as procedural. The Australian
Government Information Security Manual (ISM) recommends against sending unmarked
email, and some agencies actively block mail that arrives without a protective
marking. Without a marking, perfectly ordinary system emails from a GovCMS site
can silently fail to be delivered. GovCMS DLM closes that gap by letting you set a
default marking that is applied automatically.

It is important to be clear about what the marking is and is not. A DLM is a
**governance and handling label** — it signals how information should be treated.
It is **not encryption** and does nothing to protect the content of the email in
transit. For that you still need proper mail transport security (TLS). The module
also has no access-control role beyond the permission it provides for managing its
own settings.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set the default protective marking
   applied to outgoing email.

## Where it lives in the admin menu

GovCMS DLM does not add menu items of its own to the front end. It adds a small
settings form (protected by its own administer permission) where you choose the
default marking. See [Configuration](configuration/index.md) for the details.
