# Configuration

Crouton needs one decision to start working — which menu to build breadcrumbs from —
plus a handful of options for exactly how the trail is assembled.

## Open the settings form

1. Log in as a user with the module's administration permission (an administrator by
   default). You can grant Crouton's permission via the **Permissions** link next to
   the module on the **Extend** page.
2. On the **Extend** page, find Crouton and click its **Configure** link to open the
   settings form.

## Settings

- **Breadcrumb menu** — the menu Crouton uses to build breadcrumbs. This is the key
  setting: choose the menu whose hierarchy matches your site's information
  architecture. **If no menu is selected, Crouton does nothing** and breadcrumbs are
  built by the next applicable breadcrumb builder — effectively disabling the module.
- **Prepend a breadcrumb for the front page** — when enabled, a **Home** breadcrumb
  is added to the front of the trail. Its label can be changed through interface
  translation.
- **Append a breadcrumb for the current page** — when enabled, a breadcrumb for the
  current page is included at the end of the trail.
- **Use disabled menu items** — when enabled, Crouton will build breadcrumbs for
  ancestral menu items that are disabled. Note: if this setting is off *and* the
  active menu item is disabled, breadcrumbs fall through to the next applicable
  breadcrumb builder.
- **Hide plain-text breadcrumbs** — when enabled, the builder ignores menu links
  that aren't real links (structural, plain-text items), keeping the trail to
  genuine links only.

## Save

Save the form, then browse to a page located within your chosen menu to confirm the
breadcrumb trail now reflects the menu hierarchy.
