# Menu Link Attributes — manual setup guide

**Menu Link Attributes** (`menu_link_attributes`) adds an **Attributes** section
to the menu-link edit form so editors can attach HTML attributes — a CSS `class`,
an `id`, a link `target`, `rel`, `title`, and so on — to individual menu links
(and to their `<li>` container elements). Drupal's built-in menu-link form has no
way to set these, so this module fills the gap: values you enter are stored on the
link and rendered automatically through Drupal's normal menu theming.

Which attributes editors can set is controlled from a single admin page. There you
edit a short **YAML** document that lists each available attribute and, optionally,
its label, description, input type, and preset options. Out of the box the module
offers three attributes — `container_class`, `class`, and `target` — and you can
add, remove, or customise them. This guide is written for a **human** clicking
through the admin UI; if you want terse, token-cheap references for an AI coding
agent, read the sibling [`agent/`](../agent/start.md) docs instead.

![The Menu link attributes configuration page, showing the YAML definition of available attributes](images/settings.png)

## Where it lives in the admin menu

The configuration page sits under **Configuration → Menu Link Attributes**
(`/admin/config/menu_link_attributes/config`). It is also reachable as the
**Available attributes** tab when you are working with menus under
**Structure → Menus**. The page has two tabs:

- **List** — an overview of the module's configuration.
- **Available attributes** (`/admin/config/menu_link_attributes/config`) — the YAML
  editor where you define which attributes appear on menu-link forms.

The attributes themselves are entered per link under **Structure → Menus**, by
editing any menu link and opening its **Attributes** section.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — define which attributes editors can
   set, then use them on a menu link.
