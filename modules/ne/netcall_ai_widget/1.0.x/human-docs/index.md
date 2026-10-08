# Netcall AI Widget — manual setup guide

**Netcall AI Widget** (`netcall_ai_widget`) embeds Netcall's AI-powered
customer-engagement chat widget on your Drupal site, so visitors can hold a
conversation with Netcall's conversational AI while they browse. The module is the
bridge that places the widget — it does not reproduce Netcall's AI, it renders
Netcall's widget code using the account details you configure.

You can enable the widget **site-wide** so it appears on every page, and then
override it on a per-page or per-section basis to show a different version of the
widget in particular places. That makes it easy to run one general assistant across
the site while pointing specific sections at a more specialized widget.

Because this widget sends visitor conversations to Netcall, treat it as an
external integration: the account/embed credentials it needs should be stored
securely, and you should be comfortable that visitor messages leave your site and
go to Netcall's service (a data-egress and privacy consideration you may need to
disclose to visitors). The module depends on Drupal core only and runs on Drupal 10
and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enter your Netcall widget details and
   choose where the widget appears.

## Where it lives in the admin menu

The settings form is at **Configuration → Web services → Netcall AI Widget**
(`/admin/config/services/netcall/ai-widget`). Permissions for the module are managed
at **People → Permissions** (`/admin/people/permissions/module/netcall_ai_widget`).
