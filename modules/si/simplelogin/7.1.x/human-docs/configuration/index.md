# Configuration

All of Simple Login's styling comes from one form. The module works the moment you
enable it (with a default sky-blue background), so everything here is about making
the pages look the way you want.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Simple Login**, or navigate directly to
   `/admin/config/simplelogin`.

## The fields

**Background: image or colour.**

- **Use background image** (`background_active`) — when on, the pages use the
  uploaded **background image**; when off, they use the **background colour**
  instead.
- **Background image** (`background_image`) — upload the full-page background image
  used when the toggle above is on.
- **Background colour** (`background_color`) — the solid colour used when no image
  is active (default `#00bfff`, a sky blue). This colour is also used to tint the
  buttons and links when the option below is enabled.
- **Background opacity** (`background_opacity`) — applies a semi-transparent overlay
  over the background image, which helps keep the form card readable over a busy
  photo. (It only has an effect when an image is active.)

**Buttons and links.**

- **Button background** (`button_background`) — when on, the submit buttons and
  links are tinted with the configured background colour, so they match your brand.

**The form card.**

- **Wrapper width** (`wrapper_width`) — the width, in pixels, of the centered form
  card (default 360). Increase it (say to 500) for forms with more fields, like a
  long registration form.

**Labels.**

- **Visually hidden labels** (`visually_hidden_labels`) — on by default. The form
  fields show placeholder text instead of visible labels; the labels are kept in
  the markup for screen readers. Turn it off if you prefer visible labels.

**Removing theme CSS (for a minimal look).**

- **Unset active theme CSS** (`unset_active_css`) — removes the active theme's
  stylesheets from these pages, giving a clean, distraction-free look driven only
  by the module's own styling.
- **Unset CSS** (`unset_css`) — a list of specific stylesheet paths (one per line)
  to strip from these pages, if you want to remove only certain stylesheets rather
  than all of the theme's CSS.

Click **Save configuration**. Then open a private/incognito window and visit
`/user/login` to see the result (the styling only applies to anonymous visitors).

## What gets styled

Simple Login only touches **anonymous** users on these paths: `/user`,
`/user/login`, `/user/password`, and `/user/register`. Logged-in users and
administrators see the normal Drupal pages. The login submit button is
automatically relabelled to **"Login to Account"**.

## Advanced: extending or overriding (for developers)

- To style an additional custom login path (for example an SSO route), a developer
  can add it via `hook_simplelogin_paths_alter()`.
- To take full control of the markup, a theme can provide its own
  `templates/page--simplelogin.html.twig`; the module detects and uses the theme's
  copy instead of its own.

See the [`agent/`](../agent/start.md) docs for the template variables and the path
hook.
