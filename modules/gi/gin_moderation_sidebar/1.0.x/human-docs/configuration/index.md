# Configuration

Gin Moderation Sidebar has exactly one setting — the style of the moderation tab.

## The tab-style setting

Go to **Configuration → User Interface → Gin Moderation Sidebar**
(`/admin/config/user-interface/gin-moderation-sidebar`). You need the **Administer
site configuration** permission. The form has a single radio-button choice,
*"Choose the Moderation Sidebar tab style,"* with two options:

- **Default** *(shipped default)* — the standard styling that fits Gin's normal
  appearance.
- **High contrast** — a higher-contrast presentation for better visibility. Gin's own
  high-contrast mode also produces this look automatically.

Pick one and click **Save configuration**. The choice is stored as ordinary
configuration, so you can export it and deploy it across environments.

## What the setting does

Behind the scenes, when Gin is the active admin theme the module adds a body class of
`gms--tab-style-default` or `gms--tab-style-contrast` to admin pages and loads its
small stylesheet. That body class is also a handy hook if a themer wants to layer
further CSS overrides onto one style or the other (for example targeting
`body.gms--tab-style-contrast`). When Gin is not the active admin theme, the module
does nothing at all.

There is no per-user, per-role, or per-content variation — the tab style is a single
site-wide choice.
