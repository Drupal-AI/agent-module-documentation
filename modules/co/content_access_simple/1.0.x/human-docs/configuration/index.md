# Configuration

Setting up Content Access Simple is a short checklist of prerequisites, after which
editors get a simple per‑node "who can view this" role list. A few finer options are
config‑only for now.

## Prerequisites (do these first)

1. **Enable both modules** — `content_access` and `content_access_simple`.
2. **Turn on per‑node access for the content type.** Go to **Structure → Content
   types → *(type)* → Manage access** (`/admin/structure/types/manage/{type}/access`)
   and enable **"Per content node access control settings"**. Without this, the
   simple widget won't appear.
3. **Place the form component.** In **Manage form display** for that content type,
   enable the **Content Access Simple** component (machine name
   `content_access_simple`) and drag it to where you want it on the node form.
4. **Grant the permission.** At **People → Permissions**, give the
   **`access content access simple`** permission to the editor roles that should be
   able to change view access.

## The node‑form widget

Once the prerequisites are in place, editing a node of that type shows an **Access
and Permissions** details section with a **"Visibility"** list of role checkboxes —
the roles allowed to view the node. On save, the module merges the checked roles
(plus any hidden roles that were already granted), calls Content Access to write the
real node grants, and clears caches. So the simple checklist produces exactly the
same enforcement as the full Content Access form, just with far fewer controls.

## Config‑only settings

These live in the `content_access_simple.settings` configuration object and aren't
yet exposed in the UI — edit them via configuration import or `drush cset`:

- **`role_config.hidden_roles`** — roles removed from the editable list entirely.
  Defaults to **anonymous**, **authenticated**, and **administrator**. Add more roles
  here to keep editors from toggling them.
- **`role_config.disabled_roles`** — roles that are **shown but greyed out** (a
  disabled checkbox), useful for, say, stopping lower roles from changing access for
  higher roles.
- **`debug`** — when true, logs "complex permission" scenarios to the
  `content_access_simple` log channel.
- **`help_text_view`** — the help text shown under the Visibility checkboxes (passed
  through `Xss::filterAdmin()` before display).
- **`unpublished_message`** — the message shown on unpublished nodes. If left unset
  and the `view_unpublished` module is installed, the roles able to view unpublished
  content are listed dynamically.

## "Complex" nodes

If a node's per‑node settings have diverged from the content‑type defaults — for
example its "view own" setting differs, or a hidden role's "view" setting differs —
the module flags the node as **complex** and makes the simple widget read‑only for
it. In that case, edit access on the full Content Access form at
**`/node/{nid}/access`** instead.
