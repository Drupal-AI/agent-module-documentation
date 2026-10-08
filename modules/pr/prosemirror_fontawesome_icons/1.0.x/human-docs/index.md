# ProseMirror FontAwesome Icons — manual setup guide

**ProseMirror FontAwesome Icons** (`prosemirror_fontawesome_icons`) adds a searchable
FontAwesome icon picker to the [ProseMirror](../../../prosemirror/1.0.x/human-docs/index.md)
editor. It contributes an **Icon** button to the editor's toolbar, a dialog where
editors search all FontAwesome solid icons by name, and drag‑and‑drop insertion — so an
icon can be dropped straight into rich‑text content. The module doubles as a worked
example of the ProseMirror module's extension APIs.

Under the hood it registers an `icon` node type with ProseMirror and renders each icon
as an `<i class="fas fa-{name} pm-icon" aria-hidden="true">` tag. Because the icon name
is emitted through a core render element, it is escaped as an attribute value, so
stored‑content injection through the class list is mitigated.

Two things are needed for icons to actually appear on the public site (not just in the
editor): the **FontAwesome library must be loaded by your theme**, and the **text
format must allow the `<i>` tag with class attributes**. Without both, editors can
insert icons but visitors will not see them.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no settings page** for this module. Setup is a matter of adding an icon
element to your ProseMirror configuration and allowing the icon markup — described in
"How to use it" below.

## How to use it

1. Make sure the base **ProseMirror** module is installed and set as the editor on a
   text format.
2. Enable this module (see [Installation](installation/index.md)).
3. Add a new **ProseMirror element** named "Icons" with the machine name **`icon`**.
   The module then automatically installs the FontAwesome dependencies, registers the
   icon node type, and adds the **Icon** menu item to the editor.
4. In the same text format, make sure the filters **allow `<i>` with a `class`
   attribute**, so the icon markup survives output filtering.
5. Ensure your theme loads the **FontAwesome** library so the icons render for
   visitors.

To insert an icon while editing, open the **Icon** button (in the Embed drop‑down),
search for an icon by name, and click it — or drag it into the content.
