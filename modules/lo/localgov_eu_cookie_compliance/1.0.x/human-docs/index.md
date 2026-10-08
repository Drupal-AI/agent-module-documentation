# LocalGov EU Cookie Compliance — manual setup guide

**LocalGov EU Cookie Compliance** (`localgov_eu_cookie_compliance`) is a small
add-on for the [EU Cookie Compliance](https://www.drupal.org/project/eu_cookie_compliance)
module that ships with the LocalGov Drupal distribution. Its headline feature is a
block — the **EU Cookie settings block** — that embeds the same category-by-category
consent form that appears in the cookie pop-up, so you can place it on a dedicated
page and give visitors a permanent "Cookie settings" page where they can review and
change their choices at any time. Many public-sector and large media sites (the BBC
being a well-known example) offer exactly this kind of page.

The module leans entirely on EU Cookie Compliance for the actual consent handling —
it does not decide what is allowed or blocked itself. It simply surfaces that
module's preferences form as a block you can drop into a region or restrict to a
single page. A secondary feature improves how Google Analytics and Hotjar behave, so
those tools do not set any cookie in the browser before consent is given (rather than
setting then removing them).

Because this is part of the **LocalGov Drupal** distribution, on a stock LocalGov
site running the `localgov_scarfolk` theme the block is placed into the Content region
for you automatically. On other sites or themes you place it yourself.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and pull in the EU Cookie Compliance dependency.

There is **no configuration page** for this module itself. Setup happens in two
places you already know: **block placement** (Structure → Block layout) and the **EU
Cookie Compliance settings** form. Both are described under "How to use it" below.

## Where it lives in the admin menu

The module adds no admin settings page of its own (`configure` is `null`). You work
with it through:

- **Structure → Block layout** (`/admin/structure/block`) — to place the *EU Cookie
  settings block* and, if you wish, restrict it to your cookie-explanation page.
- **Configuration → System → Cookie compliance** — the EU Cookie Compliance
  module's own settings, where the consent behaviour is configured.

## How to use it

The intended setup, following the module's own guidance, is:

1. Create a content page that explains your site's cookies — for example at `/cookies`
   (the default) or any path you like, such as `/foo`.
2. Enable this module (see [Installation](installation/index.md)).
3. Add the **EU Cookie settings block** to the **Content** region via **Structure →
   Block layout**. On a default LocalGov Drupal site with the `localgov_scarfolk`
   theme this happens automatically.
4. In the block's visibility settings, restrict it to your cookie-explanation page so
   the settings form only appears there.
5. Configure **EU Cookie Compliance**:
   - Choose **Opt-in with categories** as the consent method.
   - List all your cookie categories under *Cookie categories with separate consent*.
   - Set the *Cookie settings page path* to the page from step 1 (default `/cookies`).
     Without this path the category-by-category form will not be provided.
   - Consider updating the button labels — *Save preferences*, *Accept all
     categories*, and the cookie-policy button label — to plain English.

Once configured, visiting any page shows the cookie pop-up; following the cookie-policy
link lands the visitor on your settings page, where they can accept or reject each
cookie category.
