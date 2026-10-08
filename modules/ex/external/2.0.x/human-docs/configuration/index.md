# Configuration

External Links works as soon as it is enabled — external links open in a new tab
site-wide. The settings form lets you **scope where** that happens and is where you
manage the module's behaviour.

## Open the settings form

1. Log in as a user with the **`administer external`** permission. This permission
   is marked as restricted-access, so grant it only to trusted roles.
2. Go to **Configuration → Content authoring → External Links**, or navigate
   directly to `/admin/config/content/external`.

## Page scope — where the behaviour applies

The main control is **which pages** the "open in a new tab" behaviour runs on. You
can enable or disable the module's effect on a per-page basis — for example, apply
it across the site but exclude a particular section, or restrict it to specific
paths. Set this to match your editorial policy for outbound links.

## How the behaviour works

External Links does not change your stored markup or add any attributes to your
links. Its JavaScript intercepts clicks on qualifying links and opens them in a new
tab, which is why the page's HTML still validates.

Because nothing is added to the link itself, there is no visible icon and no
screen-reader announcement that a link opens in a new tab. If your editorial or
accessibility policy needs that cue, add it in your theme or content — an icon on
its own is not sufficient; the cue needs to reach assistive technology through the
link's accessible name.

## Save

Click **Save configuration**. Changes take effect on the next page load.

> **A reminder before you finish:** "open in new tab" removes the back button and
> changes context, so keep its scope as narrow as your requirement genuinely needs,
> and give users a clear cue that a link opens elsewhere.
