# Configuration

Tcmb needs two small things done before the rates appear on your site: tell it
which currencies to track, then place its block into your theme.

## 1. Set your currency codes

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → System → Tcmb settings**, or navigate directly to
   `/admin/config/system/tcmb-settings`.
3. On the settings form, specify the currency **codes** you want to display — the
   short identifiers the central bank uses for each currency (for example the
   codes for US Dollar, Euro, and so on). These determine which rows appear in the
   rates table.
4. Click **Save configuration**.

## 2. Place the rates block

The rates are shown through a block, so you decide where they appear:

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Find the region of your theme where you want the rates to show (for example a
   sidebar) and click **Place block**.
3. Choose the **Tcmb: currency** block and add it to that region.
4. Save the block layout.

Reload the front end and the exchange‑rate table should now appear in the region
you chose, populated with the currency codes you configured.

## The public JSON feed (optional)

If you enabled the `tcmb_json` submodule, the rates are also exposed as a
read‑only JSON endpoint. This is handy for feeding the data to another
application, but keep in mind it is **public** — treat it as openly readable
reference data, not something to gate behind access control.
