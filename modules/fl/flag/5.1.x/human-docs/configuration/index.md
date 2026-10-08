# Configuration

Flags are configuration entities, so you build them in the admin UI and they
export as YAML like any other config. Everything starts at **Structure → Flags**
(`/admin/structure/flags`), which requires the **Administer flags** permission.

## Create a flag

Click **Add flag** and work through the form. The main settings are:

- **Machine name / Label** — the flag's internal id and its human‑readable name.
- **Flaggable entity type** — what the flag can be attached to, for example
  *Content* (`node`), *Comment*, or *User*.
- **Bundles** — which bundles of that entity type the flag applies to. Leave it
  empty to apply the flag to all bundles.
- **Scope (global vs. per‑user)** — a **global** flag has one shared state for the
  whole site (good for an editor‑controlled "Featured" flag that everyone sees);
  a **per‑user** flag records a separate state for each user (good for bookmarks,
  favorites, and follows).
- **Flag link text** — the **flag short**, **flag long**, and **flag message**
  strings shown when a user *can* flag: the link label, its description, and the
  confirmation message.
- **Unflag link text** — the matching **unflag short / long / message** strings for
  removing the flag, plus **unflag denied text** shown when a user may flag but is
  not allowed to unflag.
- **Flag type** — the Flag Type plugin (entity, comment, or user) that governs what
  is being flagged. This follows from the entity type you picked.
- **Link type** — the Action Link plugin that controls how the flag/unflag
  interaction renders:
  - **AJAX link** — toggles instantly without a page reload.
  - **Confirmation form** — asks the user to confirm first (useful for a *report*
    flag).
  - **Reload** — toggles and reloads the page (the default).
  - **Field entry form** — opens a form when flagging, so the user can fill in
    fields on the flagging.
- **Weight** — controls ordering when several flags appear together.

Save the flag and it becomes available on the chosen entities. From the flags list
you can also **enable**, **disable**, or **reset** a flag (reset removes every
flagging of that flag).

## Add fields to a flagging

Because each flagging is its own entity, you can attach fields to it. Open the
flag's **Manage fields** tab and add fields just as you would on a content type —
for example a "reason" text field on a *report* flag, or a rating on a *review*
flag. The data is collected through the **Field entry form** link type.

## Permissions

Flag generates permissions automatically. Grant these under **People →
Permissions**:

| Permission | What it allows |
|-----------|----------------|
| **Administer flags** | Define and manage flags and their settings. A trusted/administrative permission. |
| **Administer flaggings** | Delete flaggings that belong to other users. Also trusted. |
| **Flag *(name)*** | Use (set) a specific flag. One is generated per flag you create. |
| **Unflag *(name)*** | Remove a specific flag. Also generated per flag. |

Because each flag you create adds its own **Flag *name*** and **Unflag *name***
permissions, you can grant the ability to use one particular flag to exactly the
roles that should have it. If a flag applies to an entity type with an owner (and
you enable the flag's **owner** option), extra "own items" / "other items"
permissions let you allow flagging only items a user owns. Global flags additionally
respect the flag type's own access rules and any `hook_flag_action_access()`
implementations.

A bulk **Delete flagging** action (`system.action.flag_delete_flagging`) is also
provided for clearing flaggings in bulk.
