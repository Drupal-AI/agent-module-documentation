# DXP Assistant — manual setup guide

**DXP Assistant** (`dxp_assistant`) wires an on‑site AI/help **assistant** into
Drupal by loading the assistant's front‑end script on your pages. In this alpha
release that is all it does: an administrator enters the assistant **script URL** on
the module's settings form, and the module adds that `<script>` to the page for the
users you allow.

The module provides two **permissions** to control access, and it targets **Drupal
10.4+ and 11**. It is an early‑stage project: the maintainers describe it as **work in
progress** (an alpha release), so expect the feature set and configuration to evolve.

The main operational concern is **egress and privacy**: the assistant script is loaded
straight from the URL you configure and runs in your visitors' browsers, so it can see
page content and may send interactions to that third‑party service — confirm the
privacy and cost implications, and only point the script URL at a provider you trust.
The module itself stores no API key or secret; the only setting is that script URL.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

The module adds a settings form at **/admin/config/user-interface/dxp-assistant**
(permission *administer dxp assistant*) with a single **script URL** field, plus a
second permission, *access dxp assistant*, that decides which users get the assistant
script on their pages. Set the URL, grant the permissions, and consult the project
page for the current steps for your release.

## Where it lives

Configure the assistant at **Configuration → User interface → DXP Assistant**
(`/admin/config/user-interface/dxp-assistant`). Grant *administer dxp assistant* and
*access dxp assistant* under **People → Permissions** to the roles that should manage
and see the assistant.
