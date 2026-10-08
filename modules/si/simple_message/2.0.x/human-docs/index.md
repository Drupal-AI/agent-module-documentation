# Simple Message — manual setup guide

**Simple Message** (`simple_message`) enables private, text‑based messaging between
users on your Drupal site. It is a lightweight way to let people send and receive
direct messages privately, with an experience aimed at feeling familiar — much like a
modern messaging app — while staying firmly within Drupal's own systems. Conversations
are stored as Drupal entities, so they are secure, extensible, and compatible with
hooks and the wider Drupal API.

Built on Drupal's Entity API, messages are implemented as entities, which means
developers can extend them and integrate them with other modules, workflows, or
functionality. Interactions are **AJAX‑powered** for a smooth experience, and the
message listing is built with **Views**, using the **Views Show More** module to page
through results. The module provides its own permissions to control who can send and
read messages.

Because this module deals with **private, personal content**, permissions are the
thing to get right. The permissions gate who can send and read messages, so grant them
deliberately and only to the roles that should have messaging. As with any messaging
system, it is also worth remembering that site administrators with database or
permission access can reach message content — private here means private between users,
not hidden from operators. The module has no other access‑control role. It supports
**Drupal 10 and 11**, and note that it is not currently covered by Drupal's security
advisory policy. The maintainer's roadmap mentions future additions such as file
attachments, real‑time notifications, group messaging, and user‑mention integration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and its dependencies)
   with Composer and enable it.

## How to use it

Once installed, the module's messaging works through its own permissions and the
Views‑based message listing:

1. **Grant the messaging permissions** at **People → Permissions**
   (`/admin/people/permissions`) to the roles that should be able to send and read
   private messages. Grant these carefully — they control access to personal content.
2. Users with those permissions can then **send and receive private messages** to and
   from one another, with the interface updating over AJAX.
3. The message list is a **View** paged with **Views Show More**, so longer
   conversations load additional messages on demand rather than all at once.

There is no central settings form to configure — the module's behaviour is driven by
the permissions you grant and the standard entity/Views infrastructure it builds on.
