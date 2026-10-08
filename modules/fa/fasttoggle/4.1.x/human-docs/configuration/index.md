# Configuration

Fasttoggle has three parts to set up: a small **settings form** that chooses the
link label style, the **per‑bundle toggles** that decide which links are offered,
and the **permissions** that decide who sees them.

## The settings form

Open the Fasttoggle settings form at **Configuration → System → Fasttoggle**
(route `fasttoggle.settings`). It has a single option, **Label style**, which
controls the wording of the toggle links:

- **Status** — the label reflects the current state (e.g. *Published*, *Sticky*).
- **Action** — the label shows what a click will do (e.g. *Unpublish*, *Promote*).
  This is the default.

Choose a style and save.

## Enabling toggles per bundle

Which toggles are offered is set on each content type and comment type, not on the
settings form:

- **Content types** — go to **Structure → Content types → [type] → Edit** and open
  the **Fasttoggle** section. Enable any of *Status (published/unpublished)*,
  *Promoted to frontpage*, and *Sticky at top of lists*, then save.
- **Comment types** — edit the comment type and enable the *Status
  (published/unpublished)* toggle in its **Fasttoggle** section.

Only the toggles you enable here appear as links, and only on the bundles where you
enabled them.

## Permissions

Fasttoggle provides two permissions, managed at **People → Permissions**
(`/admin/people/permissions`) — search for "fasttoggle":

- **Administer Fasttoggle** — access the settings form. Keep this for site
  administrators.
- **Use Fasttoggle** — see and use the toggle links. Grant this to the trusted
  content‑moderation roles that should be able to change published/promoted/sticky
  state on the bundles where fasttoggle is enabled.

## Save

Save the settings form, the content‑type / comment‑type edit forms, and the
permissions page after assigning roles. The toggle links appear for users whose
roles have the **Use Fasttoggle** permission, on the bundles where the toggle is
enabled.
