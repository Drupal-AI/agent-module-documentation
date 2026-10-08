# Configuration

All of NG Lightbox's behaviour is controlled from a single settings form. Until
you fill in at least one path here, the module does nothing.

## Open the settings form

1. Log in as a user with the **Administer NG Lightbox** permission
   (`administer ng lightbox`) — an administrator by default.
2. Go to **Configuration → Media → NG Lightbox**, or navigate directly to
   `/admin/config/media/ng-lightbox`.

## Paths

A text area, one path per line. Every path you list here opens in a lightbox
dialog. The rules:

- Each path **must start with a `/`** — for example `/contact`, `/user/login`.
- Use `*` as a wildcard — `/comment/*/reply` matches every comment reply form,
  `/about/*` matches everything under the About section.
- Matching is tried against the **internal path** first, then against the page's
  **URL alias**, so a pattern written against a friendly alias still catches the
  underlying `/node/12` and vice versa.
- Leave it empty and nothing is lightboxed (this is the default).

## Default Width

The width of the dialog, in pixels. Defaults to **700**. This is passed straight
to core's dialog as its `width` option, so raise or lower it to fit your design
(for example 900 for a wider form).

## Lightbox Class

An optional extra CSS class added to the dialog (as core's `dialogClass`). Leave
it blank unless your theme needs a hook to style these particular dialogs — set
something like `my-lightbox` and target it from your theme's CSS. Empty by
default.

## Skip all admin paths

A checkbox, **on by default**. When ticked, links on administrative pages are
never turned into lightboxes, even if they match your patterns — which keeps the
back‑office working normally. Untick it only if you genuinely want admin links to
open in dialogs too.

## Renderer

A select list choosing how the dialog is drawn:

- **Core Modal** (`drupal_modal`) *(default)* — a modal overlay that dims the
  rest of the page and must be dismissed before you can interact with anything
  behind it.
- **Core Dialog** (`drupal_dialog`) — a non‑modal dialog that floats over the
  page without blocking the rest of it.

If another module registers its own main‑content renderer, it can appear here as
an extra option automatically.

## Save

Click **Save configuration**. Changes take effect immediately — reload a page
containing a matching link and it will open in the dialog you configured.
