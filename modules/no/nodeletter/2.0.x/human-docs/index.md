# Nodeletter — manual setup guide

**Nodeletter** (`nodeletter`) turns a published content **node** into a newsletter and
sends it out through **Mailchimp**, without editors ever leaving Drupal. When a content
type is enabled for Nodeletter, each node of that type gains a **Newsletter** tab: from
there an editor picks recipients within a configured Mailchimp list, sends a **test
mail** to a single address, or triggers the **real send**. Every send is recorded as a
`nodeletter_sending` entity so you have a history of what went out.

The idea is to keep the whole editorial workflow inside Drupal — you prepare content
with familiar content types and fields, and Nodeletter maps that field data onto a
template managed in Mailchimp. Node types are configured individually: for each one you
choose a Mailchimp list, a template, and how node fields map to the template's
variables. Under the hood a pluggable "sender" architecture does the API work (Mailchimp
is the bundled implementation), so other providers can be added by developers. It depends
on core **Node** and **Field**, plus the contributed **Mailchimp** module. An optional
submodule, **Nodeletter Blocks** (`nodeletter_blocks`), can expose the sending form as a
block.

Real sending is protected by a global master switch (`nodeletter_allow_sending`) and the
per‑node form is properly gated — it requires update access to the node, the node to be
published, and the content type to have Nodeletter enabled. **One safety caveat with the
blocks submodule:** the sending form itself has no intrinsic access check and relies on
where it is placed. If you put the Nodeletter Blocks "sending" block on a page anonymous
users can reach, they could trigger the test‑mail send (to an arbitrary address) and, if
the master switch is on, a real send — so restrict that block's visibility carefully.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its Mailchimp
   dependency, and enable it (and optionally the blocks submodule).
2. [Configuration](configuration/index.md) — connect Mailchimp, set the global send
   switch, enable and map content types, and send safely.

## Where it lives in the admin menu

- Global settings: **Configuration → Web services → Nodeletter**
  (`/admin/config/services/nodeletter`).
- Per‑content‑type settings: **Structure → Content types → *(type)* → Manage** →
  the **Nodeletter** tab (`/admin/structure/types/manage/{type}/nodeletter`).
- Sending history: `/admin/nodeletter/sendings`.
- Per‑node sending: the **Newsletter** tab on a node (`/node/{node}/nodeletter`).
