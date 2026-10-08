# Media Power BI — manual setup guide

**Media Power BI** (`media_power_bi`) lets editors embed Microsoft Power BI
reports and dashboards into your site as Media entities. It adds a **"Media Power
BI"** media *source*, so once you create a media type that uses it, editors can
paste a Power BI embed URL and have that interactive report available anywhere
Media works — media reference fields, the Media Library, and the CKEditor media
embed button.

Behind the scenes the module validates what editors paste: the URL must be
non‑empty and its host must be one of the trusted Power BI domains
(`app.powerbi.com`, plus the US Government cloud hosts `app.powerbigov.us`,
`app.high.powerbigov.us`, and `app.mil.powerbigov.us`). Anything else is rejected
with a friendly message telling the editor to re‑copy from Power BI's share/embed
dialog. For display, it renders the report inside a controlled `<iframe>`, so you
get governed, safe embedding without anyone hand‑writing iframe markup. A display
formatter lets you set the iframe **width** (default `100%`) and **height**
(default `900px`) per view mode.

There is no admin settings page and the module adds no permissions of its own —
Power BI media is managed with the same permissions and workflow as any other
media. It does depend on core's **Media** and **Media Library** modules, which
Drupal enables for you as dependencies. Setup is done entirely through the
standard Media type screens: create a media type using the Power BI source, then
embed reports through the Media Library or a media field.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Media Power BI adds no settings page of its own. You work with it through Drupal's
standard Media screens:

- **Structure → Media types** (`/admin/structure/media/add`) — where you create
  the Power BI media type.
- **Content → Media** and the **Media Library** — where editors add and manage
  Power BI reports.

## How to use it

**1. Create the media type.** Go to **Structure → Media types → Add media type**
(`/admin/structure/media/add`). Give it a name such as "Power BI", and for
**Media source** choose **Media Power BI**. Save. Drupal automatically creates the
long‑text source field that stores the embed URL.

**2. Set the display size (optional).** On the new media type's **Manage display**
page, set the source field's format to **Media Power BI**. Click the gear and
adjust **width** and **height** if you want something other than the full‑width
`100%` × `900px` default (any valid CSS unit works — for example `100%` × `600px`
for a shorter embed). You can use different sizes in different view modes (say a
smaller teaser and a full‑size full view).

**3. Add a report.** In the Media Library (or on the media add form), paste the
Power BI share/embed fragment into the **Embed Code** box. If the URL is a valid
Power BI address it is saved; otherwise you'll see a clear error asking you to
re‑copy it from Power BI.

**4. Place it.** Reference the Power BI media item from a media field, drop it into
a Paragraph or Layout Builder component, or insert it in CKEditor via the media
embed button. Because it's a reusable Media entity, updating a report's URL in one
place updates every page that embeds it.
