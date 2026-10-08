# Configuration

Configuring Node Option Premium is mostly about **permissions** — who may see full
premium content, and who may toggle the premium flag — plus an optional message
form. Before you start, keep the key caveat in mind: this hides the *display*, not
the *data* (see "What 'premium' actually protects" at the end).

## Set the permissions

1. Log in as an administrator and go to **People → Permissions**
   (`/admin/people/permissions`).
2. For each content type you care about, configure the two permissions the module
   provides:
   - **View full *[type]* premium content** — roles with this permission see the
     complete node. Roles without it see only the teaser plus the non‑premium
     message.
   - **Override premium option** — lets a user *without* the broad *Administer
     nodes* permission change the **Premium content** checkbox when editing a node
     of that type. This mirrors what the *Override Node Options* module does for
     core publishing options. Grant it to editors you want to be able to mark
     content premium.
3. Click **Save permissions**.

## Who can fully view a premium node

Beyond anyone holding the *view full [type] premium content* permission, a premium
node is also shown in full to:

- any user with the **Administer nodes** permission,
- the **author** of the node, and
- any user with the **edit any [type] content** permission.

Everyone else gets the teaser and the message.

## Mark content as premium

Edit a node and tick **Premium content** in the Publishing options, then save.
Alternatively, use the bulk **node operations / actions** the module provides —
*Make content premium* and *Make content non‑premium* — from the content admin
listing to flag several nodes at once.

## Customise the non‑premium message

The message shown to users who only get the teaser can be tailored per content
type:

1. Go to **Configuration → Workflow → Node Option Premium**
   (`/admin/config/workflow/nopremium`).
2. Edit the message text for each content type as you wish (for example, a
   sign‑up call to action). The message can also be themed if you need more than
   plain text.
3. Save.

## Views, Rules and search

- **Views:** the module exposes a *Premium content* field, filter and sort, so you
  can build listings that account for the premium flag. (Note: the premium
  restriction does not apply to individual fields rendered in Views — control that
  at the theming level if needed.)
- **Rules:** a *Content is premium* condition is available; combine it with Rules
  Scheduler if you want time‑limited premium content (there is no built‑in
  time‑limit feature).
- **Search:** a Search API processor keeps premium content out of search results.

## What "premium" actually protects

This is the essential caveat. Node Option Premium is a **presentation
restriction**, not access control: it swaps the view mode to the teaser for
unprivileged users but does not restrict node view access or alter field values.
The full body and fields remain readable through any path that loads the node —
JSON:API, REST, Views fields and feeds among them.

So treat the premium flag as a **presentation hint, never as protection**. It is
right for a soft marketing gate over non‑secret content. If the content must truly
be withheld (paid or confidential material), add real field/node access control
and disable or filter JSON:API/REST for the affected content types — the premium
option alone will not keep that data private.
