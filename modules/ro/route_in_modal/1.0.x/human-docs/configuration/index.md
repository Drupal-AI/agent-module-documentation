# Configuration

All the setup happens on one screen: **Configuration → User interface → Route In
Modal** (`/admin/config/user-interface/route-in-modal`). You need the **administer
route_in_modal** permission to open it.

## The settings, field by field

- **Routes** — a textarea where you list the routes to open in a modal, **one per
  line**. Enter each route by its Drupal route name, and pass any route parameters
  as part of the string. You can also override the dialog size for a single route
  by appending a suffix such as `|width:600,height:400`; a route without a suffix
  uses the defaults below.
- **Dialog width** — the default width for the modal dialog, applied to every
  listed route that doesn't set its own.
- **Dialog height** — the default height, likewise applied unless a route
  overrides it.

## How it behaves once saved

After you save the list, the module quietly rewrites the relevant links: any link
pointing at one of your listed routes gets the `use-ajax` class and a
`data-dialog-type=modal` attribute, so clicking it opens the target inside a
Drupal core modal at the configured size. Menu links and other destinations that
resolve to a matching route become modal launchers automatically — no template or
JavaScript changes needed on your side.

Forms rendered inside the modal are wrapped to submit over AJAX. If validation
fails, the errors show inside the dialog rather than reloading the page; on a
successful submit a confirmation message appears and the underlying page can
refresh so the visitor keeps their place.

If you want to style the dialog, target the `route-in-modal` dialog class in your
theme's CSS.

## Save

Click **Save configuration**. Visit a page with a link to one of your listed
routes and click it — it should now open in a modal instead of navigating away.
