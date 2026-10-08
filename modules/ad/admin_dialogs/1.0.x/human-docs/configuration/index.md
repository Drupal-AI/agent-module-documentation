# Configuration

All configuration happens at **Configuration → User interface → Dialog Groups**
(`/admin/config/user-interface/dialogs`). You need the **Administer dialogs**
permission. **Clear caches after any change** — the rules alter cached render arrays
and page attachments, so edits won't fully take effect until you do.

## The two building blocks

- **Dialog Group** — a container with an `id`, a **label**, and a **description**.
  Its only job is to keep related dialogs organized. Open a group to see and manage
  the dialogs inside it.
- **Dialog** — one rule. This is where the real work is described.

## Creating a Dialog

Each Dialog has these settings:

- **Type** — which class of UI element the rule targets:
  - **`ops`** — entity operation links (the *Edit* / *Delete* links on admin lists).
  - **`tasks`** — local task tabs (Edit, Manage fields, etc.).
  - **`actions`** — local action links (e.g. the "Add" buttons above a list).
  - **`paths`** — specific URL paths.
  - **`selectors`** — any links you match by CSS selector.
- **Dialog type** — **Modal** (a centered overlay) or **Off‑canvas** (a panel that
  slides in from the side).
- **Dialog width** — the width in pixels.
- **Dialog title override** — optional; replaces the default dialog title.
- **Dialog group** — which group this rule belongs to.
- **Status** — whether the rule is enabled.
- **Selection criteria** — how the rule decides where it applies: an **entity type**
  and optional **bundles**, an operation **key**, **paths**, **routes**, or
  **selectors**, depending on the type you chose.

For example, to make the *Delete* confirmation on articles open as a modal, you'd
create an `ops` Dialog, choose **Modal**, and scope its selection criteria to the
`node` entity type / `article` bundle with the `delete` operation key.

## The global settings form

At `/admin/config/user-interface/dialogs/settings` a handful of convenience toggles
control site‑wide defaults:

| Setting | Default | What it does |
|---|---|---|
| **Delete ops** (`delete_ops`) | On | Allow dialogs on *Delete* operation links. |
| **Delete buttons** (`delete_buttons`) | On | Turn the **Delete** button on content forms into a modal button. |
| **Other buttons** (`other_buttons`) | On | Enable dialogs on additional buttons and on the Views UI Delete/Duplicate top links. |
| **Submit spinner** (`submit_spinner`) | Off | Show a loading spinner on admin form submit buttons. |

## Bundled configs

The ~40 ready‑made Dialog and Dialog Group configs that ship with the module install
automatically when their target modules (core admin pages, Pathauto, Redirect,
Linkit, Media, Aggregator, CAPTCHA and more) are present. You can enable, disable, or
edit any of them, and you can add dialog behavior to your own module's admin links by
shipping your own `admin_dialog` config.
