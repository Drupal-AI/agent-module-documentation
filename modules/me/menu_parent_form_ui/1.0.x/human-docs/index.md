# Menu Parent Form UI — manual setup guide

**Menu Parent Form UI** (`menu_parent_form_ui`) replaces the single, long "parent
link" dropdown on menu forms with a series of cascading select boxes — you choose the
menu, then the parent, then the sub‑parent, one step at a time. It's a client‑side
(JavaScript) improvement to how editors pick where a menu link sits.

The problem it solves is scale. Drupal's default parent selector flattens the whole
menu tree into one giant dropdown, with dashes indenting each level. On a large or
deep menu that list becomes unusable — you scroll forever and it's hard to tell one
level from another. Cascading selects break the choice into manageable steps that
mirror the menu's actual hierarchy, so finding the right parent is fast even on big
menus. The improved selector appears both on the node edit form and on the "add
link" form under Structure → Menus.

This is purely a content‑editing/form‑UI enhancement — it changes *how* the parent is
chosen, not the menus themselves or anyone's access. It works as soon as you enable
it, with no per‑link setup, and depends on core's **Menu UI** module. (One caveat: it
reads the menu levels from the leading dashes Drupal prints in the option text, so it
relies on core continuing to render that list the same way.)

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

The module works the moment you enable it — there's nothing you *must* configure. It
does provide a small settings form at `menu_parent_form_ui.settings` for fine‑tuning
its behavior; most sites can leave it at its defaults.

## How to use it

Just enable the module. From then on, whenever you edit a node or add a menu link at
**Structure → Menus** (`/admin/structure/menu`), the single parent dropdown is
replaced by cascading select boxes: pick the menu, then the parent, then the
sub‑parent, drilling down to exactly the spot you want. There's no per‑link setup and
nothing to switch on for individual links.
