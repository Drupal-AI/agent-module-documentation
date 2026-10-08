# Configuration

Fluid UI has a single settings form that controls how the Fluid Infusion preferences
panel behaves on your front end.

## Open the settings form

1. Log in as a user who can reach administration pages.
2. Go to **`/admin/config/fluidui/adminsettings`** (route
   `fluidui.admin_settings_form`).

> **A note on the permission that guards this form.** The settings page is protected by
> the **Access administration pages** permission, not the stricter **Administer site
> configuration** that most configuration forms use. *Access administration pages* is
> granted to fairly ordinary staff roles on many sites, yet this form changes site‑wide
> front‑end behaviour. If your site gives that permission out widely, consider whether
> you want to tighten access to this page, or at least flag it in an access review.

## What the form controls

The form governs the Fluid Infusion **UI Options** panel — the set of presentation
preferences your visitors can adjust and that Infusion remembers via cookies. The
preferences Infusion provides are:

- **Font size / text zoom** — let visitors scale the page's text up or down.
- **Line height** — increase spacing between lines for easier reading.
- **Font style** — switch to a more readable typeface.
- **Contrast** — apply alternative contrast themes.
- **Link style** — emphasise links so they stand out from body text.

Adjust the options offered to visitors here, then save. Because internationalisation for
this module is handled through JSON files inside the module folder rather than Drupal's
translation UI, translating the panel's labels is done in those files — see the
module's `README` for details.

## Things to check after saving

- **Some themes need extra CSS.** With certain themes (Bootstrap‑based ones, for
  example) font‑size or line‑height changes only take effect once the theme uses
  percentage or `em` values. If a preference appears to do nothing, add the small
  amount of CSS the theme needs.
- **Contrast and gradients.** Contrast settings do not apply to elements styled with
  CSS gradients.
- **Preferences are cookie‑based.** A visitor's choices persist through cookies, so they
  carry across pages for that visitor.

## Save

Click **Save configuration**. The preferences panel updates for front‑end visitors
according to your settings.
