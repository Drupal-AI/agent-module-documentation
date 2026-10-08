# Jotform Field Widget — manual setup guide

**Jotform Field Widget** (`jotform_field_widget`) provides a **field widget** that
lets an editor select a **Jotform form by its Form ID** when filling in content. It
works on any **string** field type, so you add a plain text field to a content type
and switch its edit widget to the Jotform picker.

Alongside the widget, the module ships a **service** that instantiates a Jotform API
client (built on the official
[`jotform-api-php`](https://github.com/jotform/jotform-api-php) library), which the
widget uses to talk to your Jotform account and which custom code can reuse.

It's a lightweight, focused module: it gives editors a way to attach a Jotform form
reference to content and provides basic API access. If instead you want Jotform
forms rendered as native Drupal forms — with server‑side validation and automation
triggering — look at the separate **Jotform API** module, which is a more
full‑featured integration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set your Jotform API key and put the
   widget on a field.

## Where it lives in the admin menu

The settings form is at **Configuration → Web services → Jotform Field Widget**
(`/admin/config/services/jotform-field-widget`), where you enter your Jotform API
key. The widget itself is chosen per field on a bundle's **Manage form display**.
