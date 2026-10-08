# Configuration

There are two parts to setting up AdSense: entering your global account details
and switches on the settings forms, and then actually placing ads on the site.

## Open the settings form

1. Log in as a user with the **Administer adsense** permission.
2. Go to **Configuration → Web services → AdSense**
   (`/admin/config/services/adsense`).

## The main settings

The main form (route `adsense.main_settings`) holds your account details and the
global switches:

- **Publisher ID** — your Google AdSense `ca-pub-…` code. This is the one
  essential value; every ad unit reuses it. Nothing will render as a real ad until
  this is filled in.
- **Disable AdSense** — a master off switch that suppresses every ad site-wide.
  Handy for temporarily pulling all ads without deleting any configuration.
- **Test mode** — flags ad requests as tests so they do not count as real
  impressions. Turn it on while verifying placement.
- **Show placeholders** and **placeholder text** — when ads are disabled or you
  are developing, the module draws a labelled box (default text "Google AdSense")
  where each ad would go, instead of calling Google. This is on by default and is
  the safe way to build out your layout. The placeholder text is what appears
  inside that box.

Additional pages cover the modern ad code and custom search:

- **Managed settings** (`/admin/config/services/adsense/managed`) — controls
  asynchronous versus synchronous/deferred ad code, and the **Auto ads**
  (page-level ads) switch described below.
- **Custom search settings** (`/admin/config/services/adsense/cse`) — appearance
  options for Google Custom Search ad units (logo, colours, encoding, language,
  country, frame width, ad location).

Click **Save configuration** on each form to store your changes.

## Auto ads (page-level ads)

If you would rather let Google decide where to place ads than position each unit
yourself, enable **Auto ads** on the managed settings page. When on, the module
injects Google's page-level ad snippet into the `<head>` of your pages
automatically — no blocks required. You can restrict which pages get Auto ads (or
exclude specific paths) using the path-visibility setting on that form.

## Placing ads as blocks

The most common way to show a specific ad unit is a block. Go to **Structure →
Block layout** (`/admin/structure/block`), place the **Managed ad** block
(`adsense_managed_ad_block`) into a region, and configure it:

- **Ad slot** *(required)* — the ad ID from your AdSense account (for example
  `1234567890`).
- **Ad format** — `responsive` (the default, which flexes to fit its container),
  `custom` (a fixed size), or special formats like `in-article`, `in-feed`,
  `autorelaxed` (matched content), `link`, or a size key such as `300x250` or
  `728x90`.
- **Width / height** — only used when the format is `custom`.
- **Shape** — for responsive units, a hint of `auto`, `horizontal`, `vertical`,
  or `rectangle`.
- **Layout key** — used by the `in-feed` format to match your listing design.
- **Alignment** — left, center (default), or right within the block.

There is also a **Custom search ad** block (`adsense_cse_ad_block`) for search
units.

## Placing ads inline with a filter tag

To drop an ad into the middle of an article, enable the **AdSense tag** filter
(`filter_adsense`) on a text format at **Configuration → Content authoring → Text
formats and editors**. Editors can then type tags directly in body text:

- `[adsense:responsive:1234567890]` — the `format:slot` form, which renders a
  managed ad.
- `[adsense:block:my_ad_block]` — render an existing AdSense block by its machine
  name.

The filter replaces each tag with the rendered ad when the page is displayed.

## Permissions

Under **People → Permissions** the module defines three permissions:

- **Administer adsense** — access to all the settings forms above. Grant only to
  trusted administrators.
- **Hide adsense** — users in a role with this permission see *no* ads at all;
  useful for editors or paying subscribers.
- **Show adsense placeholders** — users with this permission see placeholder boxes
  where ads would be, rather than real ads; useful for QA and layout work.

The last two are evaluated per user independently of the global placeholder and
disable switches.

## A safe development workflow

While building the site, leave **Show placeholders** on (the default) and/or turn
on **Disable AdSense**. Ad units will draw placeholder boxes instead of calling
Google, so you can position everything without generating invalid traffic. When
you are ready to go live, enter the real publisher ID, turn off placeholder/test
mode, and confirm the real ads appear.
