# Configuration

BUEditor has three moving parts: **editors** (a toolbar and its settings),
**buttons** (the reusable items you put in a toolbar), and the step where you
**attach an editor to a text format** so it actually appears on your content forms.
This page walks through all three, plus the permissions and the one global setting.

## Open the admin UI

1. Log in as a user with the **Administer BUEditor** permission.
2. Go to **Configuration → Content authoring → BUEditor**, or navigate directly to
   `/admin/config/content/bueditor`.

You'll see a list of editors, a **Buttons** tab (`/buttons`), and a **Settings** tab
(`/settings`).

## Editors

An editor (`bueditor_editor` config entity) is a toolbar plus a few behaviour
settings. From the editors list you can **add**, **edit**, **duplicate**, or
**delete** editors. Duplicating an existing editor is the quickest way to start a new
one. Each editor has:

- **Toolbar** — the ordered list of items (buttons and plugin buttons) shown in the
  toolbar. Arrange them in the order you want them to appear.
- **Class name** — an optional CSS class on the editor, for theming.
- **Indentation** — toggle automatic indentation of the source.
- **HTML tag autocomplete** — when on, the editor autocompletes HTML tags as you
  type.
- **File browser** — the file browser to attach for inserting file/image links.

## Buttons

A button (`bueditor_button` config entity) is a reusable toolbar item. From the
**Buttons** list you can add, edit, duplicate, and delete them. A button carries:

- **Label** and **Tooltip** — what it shows and its hover text.
- **Class name** — an optional CSS class for styling the button.
- **Keyboard shortcut** — an optional shortcut that triggers it.
- **Code** — the text/snippet inserted into the textarea when the button is used
  (for example a Markdown or HTML snippet).
- **Template** — HTML injected into the editor UI.
- **Libraries** — any asset libraries the button needs.

Custom button IDs are automatically prefixed with `custom_`. Once a button exists,
add it to an editor's **Toolbar** to make it appear.

> **Security note.** Buttons can define the code, HTML template, and libraries they
> inject, so **Administer BUEditor** is a trusted, restricted permission — only grant
> it to administrators you trust with that power.

## Attach an editor to a text format

Creating an editor doesn't change any content form until you attach it to a text
format:

1. Go to **Configuration → Content authoring → Text formats and editors**.
2. Edit the text format your authors use.
3. Choose **BUEditor** as the **Text editor**.
4. Pick which BUEditor instance is the default, and optionally set different editors
   per role.

Now every field that uses that text format shows your BUEditor toolbar.

## Permissions

Set these at **People → Permissions**:

- **Administer BUEditor** (`administer bueditor`) — *restricted*. Gates the entire
  BUEditor admin UI and who can create/edit editors and buttons. Because button
  holders can inject code and libraries, treat this as an admin-only permission.
- **Access AJAX preview** (`access ajax preview`) — controls the live "Preview"
  button, which renders the editor's content through its text format via an AJAX
  request. Grant it to roles that should get the preview button. It only ever renders
  formats the user already has access to and reflects the result back to the same
  person, so it does not widen anyone's privileges.

## Global settings

The **Settings** tab (`/admin/config/content/bueditor/settings`) has a single
option:

- **Development mode** (`devmode`) — off by default. When on, BUEditor loads the
  un-minified version of its JavaScript library, which is useful when debugging or
  developing plugins. Leave it off in production.

## Save and test

After saving your editor and attaching it to a text format, open any content form
that uses that format and confirm your toolbar and buttons appear and behave as
expected.

## Extending in code

Developers can add new buttons or alter the editor's JavaScript and forms with a
`bueditor_plugin` plugin (the bundled standard buttons and the AJAX preview button
are supplied this way). See the sibling [`agent/`](../agent/start.md) docs for the
plugin interface and examples.
