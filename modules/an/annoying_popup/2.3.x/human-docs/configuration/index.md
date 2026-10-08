# Configuration

Annoying Popup stores each popup as a configuration entity, so you create and
manage them from one admin listing.

## Open the popup listing

1. Log in as a user with the **Administer annoying popups** permission.
2. Go to **Configuration → System → Annoying Popup**, or navigate directly to
   `/admin/config/system/annoying_popup`.

This page lists your existing popups and lets you add a new one.

## Create a popup

Add a popup and enter the message you want visitors to see. Save it, and the popup
is shown as an overlay to visitors.

> The popup content is rendered exactly as you enter it, so only use markup you
> trust.

## Dismissal and the cookie

When a visitor dismisses a popup, the module sets a browser cookie so the same
visitor is not shown it again until that cookie expires. This is worth noting for
cookie‑consent purposes: enabling this module means a cookie is set on visitors'
browsers.

## Permissions

Grant the **Administer annoying popups** permission (under **People →
Permissions**) to the roles that should manage popups.
