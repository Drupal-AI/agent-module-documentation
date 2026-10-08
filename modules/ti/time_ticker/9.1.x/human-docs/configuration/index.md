# Configuration

Getting a live clock on your site is two short steps: choose the timezone on the
settings form, then place the block in a region.

## 1. Set the display timezone

1. Log in as a user with the **Administer blocks** permission (an administrator by
   default). Note that this — rather than a regional-settings permission — is what
   gates the form.
2. Go to **Configuration → Regional and language → Time Ticker**, or navigate
   directly to `/admin/config/regional/time-ticker`.
3. Choose the **timezone** you want the clock to display, and save.

The module stores this single timezone value and formats the current time for it in
the style `jS M Y - h:i:s A`.

## 2. Place the Time Ticker block

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Find the region where you want the clock — a header or footer is common — and
   click **Place block**.
3. Choose the **Time Ticker** block, configure the usual block visibility settings
   (which pages, which roles) if you wish, and save.

The clock now appears wherever you placed the block, updating live. Because it is a
normal block, you can place it in a global region to show it across many pages.

## How the live update works

A small JavaScript library polls the read-only endpoint `/time_ticker/ajax`, which
returns the formatted current time as JSON. That endpoint exposes only the formatted
time string — no user or system data — so there is nothing sensitive behind it. If
you ever need the value elsewhere, you can poll the same JSON endpoint from your own
JavaScript.

## Theming

The clock output is rendered through the module's Twig template, so you can override
it in your theme if you want to restyle how the date and time appear.
