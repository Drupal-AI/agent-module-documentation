# Configuration

Webform Group has no single settings page. Its configuration lives in three places:
the **group‑role access selectors** on each webform, the **per‑element access**
controls, and the **site‑wide email‑recipient allowlist**. This page walks through
each. Remember that everything here only takes effect for a webform whose source
entity is a group‑related node.

## Group‑role access on a webform

1. Go to **Structure → Webforms**, open the webform that is attached to a group
   node, and choose **Settings → Access**.
2. Every access permission row now has an extra **Group (node) roles** selector
   alongside Webform's usual user‑role and user selectors. The rows cover:
   - **Create** submissions.
   - **View / Update / Delete / Purge** submissions, each split into **any** and
     **own** (own also requires the user to be the submission's owner).
   - **Administer submissions (Groups only)** — a dedicated section that grants
     broad submission management without needing a global site permission.
3. Pick the group roles that should get each permission. Access is granted when the
   current user's group roles for that webform's group overlap the roles you
   select. The selector lists roles grouped by group type and includes Group's
   **implied** roles (outsider / insider / member), so you can, for example, grant
   "view own" to every member.

Because these choices are stored on the webform itself, the same rules travel with
the webform — but they are always evaluated against *the group the current node
belongs to*, so one webform reused across many groups stays correctly scoped to
each group's own members.

## Per‑element group‑role access

Individual webform elements can also be restricted by group role:

1. In the Webform UI, edit an element and open its **Access** section.
2. Each of **Create**, **Update**, and **View** access gets its own **Group roles**
   selector.
3. Choose the group roles allowed to perform that operation on the element.

Note the built‑in warning: if an element's ordinary user‑role access already grants
*anonymous* or *authenticated* users, that makes the group‑role restriction moot
(anyone already has access). The form flags this so you do not accidentally leave an
element wide open. If you set no group roles on an element, it simply falls back to
the normal user‑role access.

## Site‑wide email‑recipient allowlist

Before a webform email handler can send to group members by role, you decide
site‑wide which roles are even allowed to be used as recipients. This protects
against leaking addresses to unintended roles.

1. Go to **Configuration → Webform → Handlers** (the Webform admin handlers
   settings form). Webform Group adds a section here.
2. **Allowed group roles** (`mail.group_roles`) — a selector of the group roles
   that may be used as email recipients. Anonymous and outsider roles are excluded
   from this list. Only roles you allowlist here become available in the email
   handler's recipient options. It is empty by default.
3. **Allow emailing the group owner** (`mail.group_owner`) — a checkbox. When
   ticked, the `[webform_group:owner:mail]` token (and the chained
   `[webform_group:owner:*]` user tokens) can be used to email the group's owner.
   It is off by default.
4. Click **Save**. Saving also refreshes the token cache so the newly allowed
   recipients appear immediately.

You can also set these from the command line:

```bash
drush config:set webform_group.settings mail.group_owner true -y
```

## Using the email tokens

Once roles are allowlisted, open a webform's **Emails / Handlers** and add or edit
an **Email** handler. In the **To / CC / BCC** fields you can use the Webform Group
tokens:

- `[webform_group:role:editor]` — sends to everyone holding the *editor* group role
  in the current webform node's group. Both fully‑qualified ids
  (`group_type-role`) and bare role names are offered in the token browser.
- `[webform_group:owner:mail]` — sends to the group owner (only if you enabled the
  owner option above).

These tokens are only available inside a Webform email handler's recipient fields,
and only resolve for roles you have allowlisted. If none are enabled, the handler
form shows administrators a hint linking back to the settings page.
