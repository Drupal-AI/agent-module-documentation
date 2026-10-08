# Decoupled Interface Translations — manual setup guide

**Decoupled Interface Translations** (`decoupled_interface_translations`) exposes
Drupal's **interface (locale) translations** to a headless front end over an API.
Drupal already stores translations for UI strings — the little pieces of text in
buttons, labels, and messages — in its Locale system. This module lets a decoupled
front‑end application fetch those translated strings, and (with the right
permission) send new strings or overrides back, so a headless app's interface stays
in sync with Drupal's translation system instead of maintaining a separate,
drifting copy.

Practically, it provides two API endpoints: one for a headless application to
**send strings** for translation or override, and one to **retrieve all**
translated decoupled strings. It depends on core's **Locale** module and ships its
own permissions to control who may use each endpoint. It lives in the
**Multilingual** package.

One security point is worth keeping in mind. **Reading** UI strings is generally
low‑sensitivity. **Writing** translations, however, is a privileged action:
translation strings are output to *every* visitor, so a bad actor who could write
them could inject misleading or malicious text into your interface. Gate the write
permission to trusted operators or services only. The module has no broader
access‑control role beyond the permissions it provides.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it (with
   core Locale), and assign its permissions.

This module has **no dedicated settings form**. Its behaviour is controlled
entirely through the **permissions** you grant, described in Installation — so
there is no separate Configuration section in this guide.

## Where it lives in the admin menu

The module adds no configuration page of its own. You control access to its read
and write endpoints from the standard **People → Permissions** page
(`/admin/people/permissions`), and the underlying interface translations continue
to be managed by core at **Configuration → Regional and language → User interface
translation** (`/admin/config/regional/translate`).
