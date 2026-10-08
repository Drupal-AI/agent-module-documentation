# Configuration

You configure this module by building **rules** on its settings page, each mapping a
menu to one or more roles. Go to **Configuration → System → Gin Toolbar Custom Menu**
(`/admin/config/system/gin-toolbar-custom-menu`). Reaching this form requires the
**Configure Gin Toolbar custom menu** permission (see below).

## Before you start: create the menu

The custom toolbar menu is just an ordinary Drupal menu. If you don't already have
one, build it under **Structure → Menus** (`/admin/structure/menu`) — add the links
you want your editors (or other roles) to see in the toolbar. You can also reuse an
existing menu such as *Main navigation*.

## Global option

- **Keep admin menu** — when enabled, the original administration menu stays visible
  alongside the custom menu. When disabled, the custom menu fully replaces the admin
  menu for matching roles. Individual rules can override this (see *Administration
  menu visibility* below).

## Building a rule

Add one rule per group of roles that should share a toolbar menu. Each rule has:

- **Menu** — the menu whose links replace the toolbar's admin menu for this rule.
- **Roles** — the roles this rule applies to. A rule matches when the current user
  has any of these roles.
- **Excluded roles** — roles that opt out even if they also match the *Roles* above.
  Use this to keep, say, an "administrator" role on the default toolbar even though
  it technically matches a broader rule.
- **Icons** — optional per‑menu‑link toolbar icons, so individual items in the custom
  menu get their own icon in the toolbar.
- **Administration menu visibility** — per‑rule control over the standard admin menu:
  **use global** (defer to the *Keep admin menu* option above), **hidden**, or
  **show**.

You can add several rules so that different roles each get their own toolbar menu.
When more than one rule could match a user, the module applies the matching rule
(minus any exclusions) and replaces the toolbar's admin menu with that rule's menu.

Save the form when done. (The module ships no default configuration, so the settings
object doesn't exist until you save this form once.)

## Permissions

- **Configure Gin Toolbar custom menu** (`configure gin toolbar custom menu`) —
  controls who can open this settings form. Grant it under **People → Permissions**
  to administrators.
- **Use toolbar** (`access toolbar`, core) — essential and easy to miss: any role you
  assign a custom toolbar menu to in a rule must **also** have this core permission,
  or the Gin toolbar (and therefore the custom menu) will not appear for them.
