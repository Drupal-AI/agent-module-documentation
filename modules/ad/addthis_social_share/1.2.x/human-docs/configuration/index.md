# Configuration

AddThis Social Share is configured in two places: a **basic settings form**, an
**advanced settings form**, and then you place the share buttons using **Block
layout**.

> Reminder: the AddThis service was discontinued in 2023, so these settings
> configure a script that no longer runs on a live site.

## Basic settings

1. Log in as a user with the **administer addthis settings** permission.
2. Go to **Configuration → User interface → AddThis**, or navigate directly to
   `/admin/config/user-interface/addthis`.

This form controls which AddThis services (share targets) appear on the buttons.
It also supports per-language script configuration, so you can serve a different
AddThis script per site language.

## Advanced settings

A separate advanced form provides the extra AddThis options. It sits at
`/addthis/advanced` and is gated by the **administer advanced addthis settings**
permission. Use it for the finer AddThis configuration beyond the basic service
selection.

## Place the share block

The buttons are rendered by a Drupal block, so nothing appears until you place it:

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Click **Place block** in the region where you want the buttons (for example the
   content or sidebar region).
3. Find and place the **AddThis** block, adjust its visibility settings if needed,
   and save.

The buttons now render in that region on the pages you targeted. Under the hood the
module's AddThisScriptManager service builds the AddThis third-party script include
that powers them.
