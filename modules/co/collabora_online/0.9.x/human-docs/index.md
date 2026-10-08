# Collabora Online — manual setup guide

**Collabora Online** (`collabora_online`) integrates **Collabora Online** — the
LibreOffice-based online office suite — into Drupal so people can **view and edit
office documents right in the browser**, with real-time collaborative (simultaneous)
editing. It supports Open Document and MS Office formats, and works with both the
community edition of the Collabora server (CODE) and the paid licensed version.

Under the hood, Drupal talks to a Collabora Online server using the **WOPI**
protocol, and Drupal acts as the *WOPI host* — it decides which user may open which
document and issues the access tokens the Collabora server uses. Documents are
stored as Drupal **media**, which is why the module depends on core **Media**. The
Collabora server URL and the shared secret used to sign tokens are managed through
the **Key** module, so both of those are dependencies. An optional
`collabora_online_group` submodule adds integration with the Group module.

This module needs configuration and, crucially, an **external Collabora Online
server** to talk to — the module does not include the office suite itself. You
point it at a CODE (or licensed) server, store the connection secret via a Key, and
grant the view/edit permissions to the right roles.

Because Drupal is the WOPI host, a few security points matter: the module must
**validate the access tokens** it issues so the Collabora server can only open
documents the requesting user is actually allowed to see (a host that does not bind
tokens to document *and* user access risks disclosing documents), the server URL and
shared secret should be stored as **secrets via the Key module**, and the connection
between the Collabora server and Drupal should run over **HTTPS**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it and its
   Media/Key dependencies, and stand up a Collabora server.
2. [Configuration](configuration/index.md) — the server URL, the signing key, and
   the view/edit permissions.

## Where it lives in the admin menu

Collabora Online adds its own settings form for the server connection, and its
permissions (which gate who can view and edit documents) appear on the standard
**People → Permissions** screen (`/admin/people/permissions`). Documents themselves
are managed as **Media** under **Content → Media**.
