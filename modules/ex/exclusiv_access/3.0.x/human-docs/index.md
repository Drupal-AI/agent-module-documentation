# Exclusiv Access — manual setup guide

**Exclusiv Access** (`exclusiv_access`) is a lightweight, content‑by‑content
access limitation. Rather than a global permission system, it lets you gate an
individual piece of content behind a **token** — a secret string carried in the
content's URL. Anyone who has the tokenised link can view the content; anyone who
does not is turned away, unless they hold a permission that bypasses the gate.

The classic use case is soft‑gating for a small site without a full access‑control
setup: an admin wants to share brand‑new content with newsletter subscribers a few
days before it goes fully public. They switch on Exclusiv Access for that content,
send subscribers the tokenised URL, and later turn the gate off so the content
becomes freely readable by everyone.

Be clear about what this is and isn't. A shared token is **bearer‑style access** —
whoever holds the link can view the content, and the link can be forwarded. It is
deliberately a *light* limitation for previews and unlisted content, **not** a
substitute for real per‑user access control on sensitive material. Don't use it to
protect confidential data. The module depends only on core's **Field** module and
supports Drupal 10.1+ and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no central settings form** for this module. You set it up per bundle by
adding a field, and control the bypass with a permission, both described below.

## Where it lives in the admin menu

Exclusiv Access adds no dedicated configuration page. You work with it in two
places:

- **Structure → *(your entity type)* → Manage fields** — to add the "Exclusiv
  Access" field to the bundle you want to gate.
- **People → Permissions** — to grant the bypass permission to trusted roles.

## How to use it

1. **Add the field.** Edit the fieldable entity bundle you want to gate (for
   example, a content type under **Structure → Content types → *(type)* → Manage
   fields**) and add the **Exclusiv Access** field.
2. **Turn on the gate for a piece of content.** When creating or editing content
   of that bundle, open the **Exclusiv access control** tab and enable it.
3. **Get the link.** After you save, a message shows you the **tokenised URL** —
   the link that carries the access token. Share this with the people who should
   see the content early.
4. **Grant trusted roles the bypass.** Under **People → Permissions**, give roles
   that should always be able to see gated content (editors, for example) the
   **see content without token** permission. Users with this permission view the
   content normally, without needing the token in the URL.
5. **Open it up later.** When the content should become public, edit it and switch
   the Exclusiv Access gate off; from then on it's readable by everyone.
