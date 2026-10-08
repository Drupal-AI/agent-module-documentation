# Configuration

The Bootstrap Styles settings form is where you edit the **catalog of style
options** and a few global settings. One thing to keep in mind: this form does
*not* turn any style controls on for Layout Builder. It only defines *what
options exist*. The controls themselves appear on sections and blocks through a
consumer module (Bootstrap Layout Builder) that calls the Bootstrap Styles
engine.

## Open the settings form

1. Log in as a user with the **Configure bootstrap styles** permission (an
   administrator by default; this is a restricted permission).
2. Go to **Configuration → Content authoring → Bootstrap Styles**, or navigate
   directly to `/admin/config/bootstrap-styles/settings`.

The form is assembled from the style plugins themselves, so it's organized into
the same groups editors will see (Background, Spacing, Colors, Border, Shadow,
Typography, Animation). All of it is saved into a single configuration object,
`bootstrap_styles.settings`, so your choices export and deploy with
`drush config:export`.

## Builder theme

**Layout Builder theme** switches the off‑canvas styling UI (the editing panel
that slides in from the side) between **dark** (the default) and **light**. Pick
whichever reads better against your admin theme.

## The style option lists

Most of the form is made up of **option lists** — one for background colors, one
for text colors, ones for padding and margin (including per‑breakpoint variants
for desktop, laptop, tablet, and mobile), border style/width/color, rounded
corners, box shadow, text alignment, and scroll effects.

Each list is edited as plain text, **one option per line**, in the format:

```
key|label
```

where `key` is the CSS class to apply (no leading dot) and `label` is the
human‑readable name editors see. For example:

```
bs-bg-success|Green
bs-p-3|Padding 3
bs-shadow-sm|Small
```

Add, remove, or rename lines to control exactly which choices editors get and
what they're called. A "none" / N/A option is added automatically.

## Background media

Two settings tell Bootstrap Styles which media type supplies background assets:

- **Background image** — the media **bundle and field** used when an editor picks
  a background image.
- **Background local video** — the media bundle and field used for a locally
  hosted background video.

These rely on the Media Library Form Element dependency to render the picker.

## Scroll effects (AOS)

The Animation group uses the **AOS** library for scroll‑in effects (fade, flip,
zoom, and so on). The scroll‑effects settings here wire that up — the effect
option list, plus the library type (external/remote by default, or local if you
dropped AOS into `libraries/aos`) and the data attributes used to trigger the
animations. In most cases the defaults are fine; adjust the effect list to
control which animations editors can choose.

## Save

Click **Save configuration**. Because everything lives in one config object, you
can also set individual values from the command line, e.g.
`drush cset bootstrap_styles.settings layout_builder_theme light`.

## Restricting which styles are offered

For advanced setups, a consumer module can store a per‑context whitelist of
enabled groups and plugins (via the Bootstrap Styles filter configuration) so
that only some of the styling controls appear in a given place. This is handled
by the consumer, not on this settings form.
