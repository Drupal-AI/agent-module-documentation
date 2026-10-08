# Link File Browser — manual setup guide

**Link File Browser** (`link_filebrowser`) adds a file‑explorer button to the
core Link field widget. Instead of typing a path by hand, an editor clicks the
**File browser** button on a link field, a modal file explorer opens onto a
folder you have designated for sharing (meant to live under `public://`), and
they pick a file or folder to drop into the link. On the display side it can also
render the linked file or folder as a browsable popup, with an option to open
files through the Google Docs viewer.

The typical flow is: choose the **Link with File browser** widget on your link
field, tell that widget which folder to share, and editors then browse and pick
from it while creating content. On the formatter side you can select **Link with
File browser** to show a files‑browser popup, and there is a companion *File
browser* block for surfacing shared files outside of a field. It relies on the
jQuery File Browser library for the explorer UI.

> Treat **View link file browser** as a trusted‑editor permission, keep the
> shared folder under `public://`, and do not hand this permission to untrusted
> or anonymous roles.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no central settings page** for this module. You configure it directly
on your link field's widget and display, described below.

## Where it lives in the admin menu

Link File Browser adds no top‑level admin page. Everything is configured on the
field itself, under **Structure → Content types → *(your type)* → Manage form
display** (to choose the widget) and **Manage display** (to choose the
formatter). Permissions live at **People → Permissions**
(`/admin/people/permissions`), where you will find **View link file browser**.

## How to use it

1. Add a **Link** field to your content type (or use an existing one).
2. On **Manage form display**, set that field's widget to **Link with File
   browser**, then click the gear icon and enter the folder to share by default
   (keep it under `public://`).
3. Create or edit content: the link field now shows a **File browser** button.
   Click it, browse the shared folder, and select a file. Right‑click a folder to
   add the folder itself.
4. Optionally, on **Manage display**, set the field's formatter to **Link with
   File browser** to render a files‑browser popup, with an option to open files
   in the Google viewer. There is also a *File browser* block you can place to
   share files outside of a field.
5. Grant **View link file browser** to trusted editor roles only.
