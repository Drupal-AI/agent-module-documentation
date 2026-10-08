# Seeds Development — manual setup guide

**Seeds Development** (`seeds_development`) — full name "Seeds Development Helper" — is a
small toolbox of developer conveniences for the **Seeds** distribution (and any Drupal
10/11 site). It focuses on two practical chores that come up constantly during
development: finding image styles nobody uses any more, and building tidy field groups
for content-type forms.

Its two features are:

- **Image Style Checker** — identifies **unused image styles** across the site so you
  can clean up assets that are no longer referenced. You reach it from **Media → Image
  Styles**: click **Unused Images** to list every unused style, or use the
  **Operations** link next to a specific style to inspect its usage.
- **Field Group Generator** — automatically generates **field groups** for a content
  type's form, improving the organisation of the edit screen. You reach it from
  **Structure → Content types**: pick a type, open **Manage Form Display**, and click
  the **Generate Field Groups** button. The module then creates field groups based on
  your form's fields, ready for you to review, adjust, and save.

Because this is developer tooling, it should be enabled **only in development
environments, not production** — dev helpers can expose diagnostic detail and are not
hardened for a live site. Keep it out of production and restrict it to developers.

There is no central settings form to fill in: the features surface as extra links and
buttons inside Drupal's existing Media and Content-type admin screens, so once the
module is enabled you simply use them where they appear.

This guide is written for a **human** clicking through the admin UI. If you are an AI
coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module
   (in development only).

## How to use it

- **Clean up unused image styles:** go to **Media → Image Styles**
  (`/admin/config/media/image-styles`) and click **Unused Images**, or use the
  **Operations** link on an individual style to inspect where it is used.
- **Generate field groups:** go to **Structure → Content types**, choose a content
  type, open **Manage Form Display**, and click **Generate Field Groups**. Review the
  generated groups, adjust them, and save the form display.
