# Webform Group — manual setup guide

**Webform Group** (`webform_group`) connects the **Webform** and **Group**
modules so that access to a webform — and to the submissions people make through
it — can be granted by **group role** rather than only by a global site role. If a
webform lives on a group node (a `webform_node` attached to a group via `gnode`),
this module lets you say things like "only members with the *manager* role in this
group may view the submissions" or "let *editors* update their own submissions,"
scoped to each group independently.

It works by layering group roles on top of Webform's existing access‑rules system.
It adds a "Group roles" selector to every permission row on a webform's *Settings →
Access* page, and to the create/update/view access controls on individual webform
elements. At runtime it grants access whenever the current user's group roles for
that webform's group overlap the roles you configured — including Group's implied
outsider/insider/member roles.

Webform Group also adds email tokens so a webform's email handler can notify group
members by role. `[webform_group:role:editor]` resolves to the email addresses of
everyone with the *editor* role in the current group, and `[webform_group:owner:mail]`
targets the group owner. To keep this under control, a site‑wide allowlist decides
which group roles (and whether the owner) may be used as email recipients at all.

The module adds no permissions of its own — it composes Webform's and Group's
permission systems. A bundled **Webform Demo Group** (`webform_demo_group`)
submodule ships example group types and a demo webform so you can see the
integration working quickly.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its Webform and
   Group dependencies with Composer, then enable everything.
2. [Configuration](configuration/index.md) — the group‑role access selectors on a
   webform, per‑element access, and the site‑wide email‑recipient allowlist.

## Where it lives in the admin menu

Webform Group has no top‑level settings page of its own. Instead it adds controls
to pages you already use:

- **Group‑role access** appears on each webform at **Structure → Webforms →**
  *(your webform)* **→ Settings → Access**, and on each element's access section in
  the Webform UI.
- **The email‑recipient allowlist** appears on the Webform email/handler settings
  page at **Configuration → Webform → Handlers** (the "Webform Group" section),
  stored as `webform_group.settings`.

## How to use it

1. Place a webform on a group node so it belongs to a group (this is Webform +
   Group + `gnode` working together).
2. On that webform's **Settings → Access** page, choose which group roles get each
   permission — view, update, delete, purge (any or own), and the "Administer
   submissions (Groups only)" section.
3. Optionally, on individual elements, restrict create/update/view access by group
   role too.
4. If you want email notifications sent to group members by role, first allowlist
   the roles on the email‑handler settings page, then use the
   `[webform_group:role:*]` and `[webform_group:owner:mail]` tokens in a Webform
   email handler's To/CC/BCC fields.

See [Configuration](configuration/index.md) for a field‑by‑field walkthrough.
