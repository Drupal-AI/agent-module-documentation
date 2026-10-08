# Configuration

All of Pinterest Hover Button's behaviour is controlled from a single settings
form. The values you set here are stored in the `pinterest_hover.settings`
configuration object.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Pinterest Hover**, or navigate directly to
   `/admin/config/pinterest-hover/config`.

## Load the Pinterest JavaScript

The master switch. When ticked, the module injects Pinterest's `pinit.js` script
into every page it targets, which is what makes the hover button appear. Untick it
to turn the feature off site-wide without uninstalling the module.

## Button appearance

Three settings control how the "Pin It" button looks. These map directly to the
data attributes Pinterest's script reads, and Pinterest's own "button style
options" documentation (pick **Image Hover** for the button type) describes the
same choices:

- **Size** — how large the hover button is.
- **Shape** — the button's shape (for example rectangular or round).
- **Colour** — the button's colour, to match your site's styling.

## Restrict to content types

By default the script loads on **all pages**. If instead you select one or more
**content types** here, the button is loaded only on node pages of those types —
useful when you only want pinning on, say, recipes or gallery pages and not across
the whole site.

## Exclude images with CSS selectors

Sometimes you want the hover button on most images but not a few — logos, icons,
avatars, or decorative graphics. In the exclusion field you can list **CSS/jQuery
selectors, one per line**, and any image matching a selector will be skipped. The
selectors are passed to the front end, where a small helper library filters those
images out before the button is attached.

## Save

Click **Save configuration**. Changes take effect immediately — reload a page with
images and hover to confirm the button now behaves the way you configured it.

> **Privacy note:** Enabling this feature causes visitors' browsers to load a
> script from Pinterest's servers. If your site is subject to GDPR or a similar
> policy, disclose this third-party integration in your privacy policy and, where
> required, gate it behind consent.
