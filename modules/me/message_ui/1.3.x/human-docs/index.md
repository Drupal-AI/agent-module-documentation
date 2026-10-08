# Message UI — manual setup guide

**Message UI** (`message_ui`) adds the web interface that the
[Message](https://www.drupal.org/project/message) module leaves out. Message
stores activity and log entries as Message entities, but on its own it ships
almost no way to create, view, edit, or delete them through the browser. Message
UI fills that gap with real Drupal forms and routes, plus a granular permission
system so you can decide exactly who may work with which kinds of message.

Once enabled, you get an **/message/add** page listing every message template a
user is allowed to create, create/view/edit/delete forms for individual message
instances, and a bulk‑delete screen for clearing out messages in batches. It also
adds view/edit/delete operation links to Message rows shown in Views, so you can
build moderation or audit screens without writing custom code.

The permission model is the heart of the module. Alongside broad permissions like
*Bypass message access control* and *Delete multiple messages*, it generates four
permissions for **every** message template you define — view, create, update, and
delete — so different roles can be responsible for different notification types.

Message UI has **no settings page** of its own; you configure it entirely through
permissions and by placing its routes and Views links where you want them. It
requires the Message and Views modules, and an optional submodule,
**Message Notify UI**, adds a "Send" action for notifying recipients.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it
   alongside Message and Views, and optionally enable Message Notify UI.
2. [Configuration](configuration/index.md) — the permissions, the create/edit/
   delete routes, and the bulk‑delete form.

## Where it lives in the admin menu

Message UI adds no configuration page. Its permissions appear on **People →
Permissions** (`/admin/people/permissions`) under the *Message UI* group, and the
bulk‑delete form sits at **Configuration → Messages → Delete multiple messages**
(`/admin/config/message/message_delete_multiple`). Individual messages are
reached at `/message/{id}` and their edit/delete forms.

## How to use it

Grant the appropriate permissions to your roles (see
[Configuration](configuration/index.md)), then send editors to `/message/add`.
They pick a template, fill in the create form, and the message is saved. From
there they can view, edit, or delete it, and administrators can prune messages in
bulk. To surface message operations inside an administrative listing, add the
Message UI Views field to a view of message entities.
