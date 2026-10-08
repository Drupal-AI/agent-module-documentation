# Configuration — embed buttons

Embed's whole job is to manage **embed buttons**: reusable definitions that each
appear as a button in the CKEditor toolbar. This page walks you through the Embed
buttons list, explains what an embed button entity holds, and shows how to add one
and turn it on in an editor.

> **Remember Embed is a framework.** The list of *embed types* you can choose from
> when adding a button comes from other installed modules (for example the
> **Entity** type provided by Entity Embed). If the add form offers no embed type,
> you have not yet installed a consumer module — see
> [Installation](../installation/index.md).

## Open the Embed buttons list

1. Go to **Configuration → Content authoring → Embed buttons**
   (`/admin/config/content/embed`).
2. You land on the **List** tab, which shows every embed button defined on the
   site.

![The Embed buttons list with two buttons and the Add embed button action](../images/buttons.png)

Each row in the table describes one button:

- **Embed button** — the human-readable label of the button (for example
  *File Browser* or *Node* in the screenshot above).
- **Embed type** — the kind of embed the button inserts. This comes from an
  `EmbedType` plugin supplied by a consuming module; *Entity* is the type provided
  by Entity Embed.
- **Icon** — the toolbar icon shown to authors for this button.
- **Operations** — an **Edit** button (with a drop-down for **Delete**) for
  changing or removing the definition.

Above the table sits the **+ Add embed button** button, and next to **List** is a
**Settings** tab (`/admin/config/content/embed/settings`) where you set the file
scheme and upload directory used to store button icons.

## What an embed button holds

Every embed button pairs three things:

- **Label** — the name of the button, used in the list and as its title.
- **Embed type** — the `EmbedType` plugin that decides *what* the button embeds
  and supplies its own per-button settings form. You pick this from the types
  registered by the modules you have installed; it cannot usually be changed after
  the button is created.
- **Button icon** — an image uploaded for the button, shown in the editor toolbar.
  If you do not upload one, the embed type's default icon is used.

The embed type's settings (for example, which entity types or view modes an
*Entity* embed may use) appear on the add/edit form once you have chosen the type.

## Add an embed button

1. On the **List** tab, click **+ Add embed button**.
2. Enter a **Label** for the button. Drupal generates a machine name from it,
   which you can adjust.
3. Choose the **Embed type**. The choices come from the consumer modules you have
   installed.
4. Fill in the **embed type settings** that appear below — these are specific to
   the type you selected.
5. Optionally upload a **Button icon** to represent the button in the toolbar.
6. Click **Save**. The new button appears in the list.

## Enable the button in a text format's toolbar

Adding an embed button does not by itself put it in front of authors — you enable
it per **text format**:

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
2. Click **Configure** next to the format that uses CKEditor 5 (for example
   *Full HTML*).
3. In the CKEditor 5 toolbar configuration, drag your embed button from the
   **Available buttons** area up into the **Active toolbar**.
4. Make sure any filter the embed type requires is enabled for that format.
5. Click **Save configuration**.

For CKEditor 5, Embed derives the toolbar button automatically from each embed
button you have defined, and it refreshes the editor whenever you save a button,
so your new button becomes available to that format's authors right away. A button
is only usable where the author has **use** access to the text format.
