# Configuration

VWO is configured through three forms under **Configuration → System → VWO**, all
gated by the **Administer VWO** permission. Until you set an account ID, no snippet
is added to any page.

## Settings — account ID and loading

Open **Configuration → System → VWO** (`/admin/config/system/vwo`).

- **Account ID** — your numeric VWO account ID. This is the key setting: while it
  is empty, VWO adds nothing to your pages. (If you have a full Smart Code snippet
  rather than just the ID, use the Extract Account ID form below to pull the ID
  out.)
- **Loading type** — how the VWO library loads:
  - **Asynchronous** *(default)* — adds a `preconnect` link and the inline async
    Smart Code, with an anti-flicker timeout. This is the modern, recommended
    mode.
  - **Synchronous** — adds a plain `<script src>` to the account's library file.
- **Settings timeout** — the async settings / anti-flicker timeout in milliseconds
  (default **2000**). This governs how long the page may be hidden to avoid a
  "flash" of the original content before an experiment applies.
- **Library timeout** — the library load timeout in milliseconds (default
  **2500**).

## Visibility — where the snippet loads

Open **Configuration → System → VWO → Visibility**
(`/admin/config/system/vwo/visibility`). These rules decide which pages and users
get the snippet:

- **Master toggle** — turn the whole set of visibility rules on or off. With it
  off, the snippet is effectively disabled site-wide without deleting your
  settings.
- **Content types** — limit the snippet to specific content types (for example,
  only landing pages). Leave empty for no content-type restriction.
- **Roles** — limit the snippet to specific user roles (for example, exclude
  staff or editors from experiments). Leave empty for all roles.
- **Pages** — a path list plus a mode: **only these paths**, **all pages except
  these**, or **evaluate PHP** (which needs the core PHP Filter-style module). The
  list is compared against both the internal path and its alias.
- **Per-user control** — choose whether individual users can opt in or opt out:
  **no control** (default), **opt-in**, or **opt-out**. When enabled, a checkbox
  is added to each user's edit form and their choice is stored against their
  account.

The module automatically adds the right cache contexts (user, role, path) to match
whichever filters you have enabled, so pages stay cached correctly.

## Extract Account ID — a convenience

Open **Configuration → System → VWO → Extract Account ID**
(`/admin/config/system/vwo/vwoid`). Paste the full VWO Smart Code snippet and the
form extracts the numeric account ID from it and saves it for you — handy when you
have copied the whole snippet out of the VWO dashboard.

## Deploying the configuration

All of the above lives in the `vwo.settings` configuration object, so your account
ID and visibility rules travel with a normal configuration export across
environments. You can also read or set values with Drush, for example:

```bash
drush config:get vwo.settings id
drush config:set vwo.settings loading.type sync -y
```
