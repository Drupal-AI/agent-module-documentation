# Configuration

All of this module's configuration lives on **the block itself** — there is no
separate admin settings page. You place the block once, then set the location and
choose which weather fields to show.

## Place the block

1. Log in as a user who can administer blocks and go to **Structure → Block
   layout** (`/admin/structure/block`).
2. Find the region where you want the weather to appear and click **Place block**.
3. In the block browser, locate the **IPMA weather** block and click **Place
   block** next to it.

## Choose the location and fields

The block's configuration form is where you tailor what it shows:

- **Location** — pick the Portuguese location whose weather you want to display.
  IPMA's API is organised by location, so this is the essential setting.
- **Fields to show/hide** — toggle the individual pieces of information the API
  provides (for example current conditions and the forecast details). Turn off the
  ones you do not need to keep the block compact.

You can also set the usual core block options here — the block title, which pages
or content types it appears on (visibility), and the role restrictions — just like
any other Drupal block.

## Save

Click **Save block**. The weather block appears immediately in the region you chose.
To change the location or fields later, return to **Block layout**, find the block,
and choose **Configure**.

> **Good to know:** because the data comes from IPMA's **public API**, there are no
> keys to enter and nothing secret to protect. The block simply fetches public
> weather data for the location you selected.
