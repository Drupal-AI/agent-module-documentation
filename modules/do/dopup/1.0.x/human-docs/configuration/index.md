# Configuration

Setting up a Dopup popup is a short sequence: build a webform, tag it so Dopup can
find it, place the block, and configure that block instance.

## 1. Create the webform

Go to **Structure → Webforms** and create a webform with the fields you want to
capture (for example a newsletter email field, or a "Get a Quote" set of fields).

## 2. Tag it with the `dopup` category

In the webform's **Settings → General → Categories**, add the category **`dopup`**.

> **Important:** only webforms in the `dopup` category appear in the Dopup block's
> webform picker. If your webform is missing from the picker, this tag is almost
> always the reason.

## 3. Place the Dopup block

Go to **Structure → Block layout** and place the **Dopup** block into a region.
(Stick to **one Dopup block per page** — multiple popups on the same page are
untested.)

You can use the block's standard **visibility** conditions here to restrict the
popup to specific pages, or to specific roles (for example, show it only to
anonymous visitors).

## 4. Configure the block

Open the block's settings at **`/admin/config/system/dopup/{block}`** (the
`{block}` is the block's id). The form offers:

- **Webform** — chosen through an autocomplete; only `dopup`‑tagged webforms are
  offered. This is the form shown inside the popup.
- **Position** — where the popup appears: center, one of the corners
  (left‑bottom, right‑bottom, top‑right, top‑left), or a custom position.
- **Trigger** — when the popup appears: a **delay in seconds** after page load, or
  once the visitor **scrolls to a percentage** of the page.
- **Custom styles** — raw CSS applied to the popup container, for styling to match
  your site.

Settings are stored per block (keyed by block id in `dopup.settings`), so you can
give different blocks different webforms, positions, triggers, and styles.

## 5. Grant the admin permission

On **People → Permissions**, grant **Administer dopup configuration**
(`administer dopup configuration`) only to trusted editors — this controls who can
change the block settings above.

## Reviewing captured leads

Because the popup embeds a standard webform, submissions are collected through the
normal **Webform results** UI. Review them there, and export them (for example to
CSV for a CRM import) as you would for any webform.

## Security note

The module's webform autocomplete endpoint (`/dopup/autocomplete-webform`) is
gated only by "access content" and disables entity access checks, so it discloses
every webform id and title on the site to anonymous users. Do not rely on webform
machine names being secret while Dopup is enabled. The block settings route above
is, by contrast, properly protected by the `administer dopup configuration`
permission.
