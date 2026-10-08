# Configuration

Decoupled Preview Iframe does nothing until you configure it: out of the box the
preview URL is empty and no content types are selected. This page walks through
the settings form field by field.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Decoupled Preview Iframe → Settings**, or navigate
   directly to `/admin/config/decoupled_preview_iframe/settings`.

## The settings

### Preview URL

The base URL of your decoupled front-end application's preview endpoint (for
example `https://front.example.com/preview`). This is the address the iframe
loads. While it is empty, the module stays inactive. This is the one setting you
must fill in to get any preview at all.

### Preview content types

The list of content types (bundles) that should show the iframe preview on their
node view page. Tick only the types that actually have a front-end route — an
article or landing page, say — and leave out types your front end never renders.
Content types you don't select keep Drupal's normal node view.

### Route sync

A token value the module's JavaScript uses to keep the iframe's route aligned
with the Drupal path you're viewing, so the preview shows the corresponding
front-end page. The default value works for the shipped front-end integration
pattern; only change it if your front end expects a different token.

### Draft provider

Controls how draft / unpublished previewing is authenticated against the front
end. The default is *none* (no special draft handling). Set it to match your
front-end's draft scheme — for example a Next.js-style draft mode — if you want
editors to preview unpublished content. Remember that this module supplies the
preview *URL*; the actual draft authentication is implemented and honoured by
your front end.

### Redirect anonymous visitors

Because the Drupal node page on a headless site is editorial-only, you can send
anonymous visitors elsewhere rather than let them see the bare editorial
preview:

- **Redirect anonymous** — a checkbox that turns the redirect on.
- **Redirect URL** — where anonymous visitors are sent when the redirect is
  enabled (typically the equivalent page on your live front end).

Leave the checkbox off if you don't need this behaviour.

## Save

Click **Save configuration**. Open a node of one of your selected content types
as an editor and you should see the front end's preview embedded in the page.

## If the preview shows an empty box

The iframe loads a **third-party origin** — your front-end domain. Browsers will
refuse to display it inside Drupal unless the front end allows framing from your
Drupal domain. If the preview area is blank, check that your front-end
application sends permissive framing headers (`X-Frame-Options` /
`Content-Security-Policy: frame-ancestors`) for the Drupal origin.
