# Configuration

All settings live on one form. Open it at **Configuration → Services → AdSense
Consent** (`/admin/config/services/adsense-consent`). You need the *Administer
site configuration* permission, and because the visitor-facing text you enter
here is rendered with your chosen text format, only grant that permission to
trusted administrators.

## Publisher ID

Enter your Google AdSense publisher ID in the form `pub-` followed by digits
(for example `pub-1234567890123456`). This is the master switch: the module only
attaches the AdSense loader script — and therefore only shows any ads — when this
value matches that pattern. Clearing the field disables all ads site-wide.

## How ads are served

- **Page-level (auto) ads** — turn this on to let AdSense inject ads
  automatically across the site, without you placing anything by hand.
- **AdSense block** — for a fixed ad unit in a specific spot, go to **Block
  layout** (`/admin/structure/block`) and place the **AdSense** block in a
  region. You can use page-level ads and the block together.

## Personalisation default

Choose whether ads default to **personalised** or **non-personalised**. Setting
the default to non-personalised is the privacy-friendly choice: personalised ads
then load only after the visitor opts in through the consent gate below.

## Consent gates

These settings decide which signal must be satisfied before personalised ads are
allowed to load:

- **Require explicit consent** — wait for the visitor's own consent choice
  (stored in the `ad_consent` cookie) before loading personalised ads.
- **EU Cookie Compliance** — read consent from the EU Cookie Compliance module,
  if you use it.
- **Klaro** — read consent from the Klaro consent manager. When you pick Klaro,
  also enter the **Klaro service name** so the module knows which Klaro service
  represents ad consent.

Wire this up to whichever cookie-consent tool your site already uses, so visitors
are not asked twice.

## Visitor-facing text (the `/ad-options` page)

Several rich-text fields let you write the copy shown to visitors on the public
`/ad-options` page and in the personalisation toggle:

- **Advertising consent** explanation — the main text asking for consent.
- **Ad personalisation explained** — the longer explanation on the options page.
- **Footer text when personalisation is on** and **when it is off** — short lines
  shown depending on the visitor's current choice.
- **Providers list** — one third-party ad network per line in the form
  `Name, https://example.com`. These are listed on the options page so visitors
  can see who may serve ads.

Each rich-text field is rendered through Drupal's text-format filtering, so the
output respects the format you select.

## Save

Click **Save configuration**. Once a valid publisher ID is set, ads begin serving
according to the placement and consent choices above. Visit `/ad-options` to see
the visitor-facing page your text produces.
