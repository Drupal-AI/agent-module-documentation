# Configuration

Configuring the module is two steps: set the site-wide embed defaults, then place
the block.

## 1. Set the embed defaults

1. Log in as an administrator.
2. Go to **Configuration → Web services → Sessionize Embed Block**, or navigate
   directly to `/admin/config/services/sessionize_embed_block`.

On this form:

- **Sessionize web embed ID** — enter the embed ID from your Sessionize event. This
  is what tells the widget which event's schedule/sessions/speakers to display.
- **Embed style** — choose one of the styles from the dropdown. Six are offered:
  four currently supported embed styles plus two "retired" ones. Pick the layout
  that matches how you want the agenda to appear.

These values are the **site-wide defaults** for the block. Save the form when done.

## 2. Place the block

1. Go to **Structure → Block Layout** (`/admin/structure/block`).
2. Add the **Sessionize Embed Block** to whichever region of your theme should show
   the agenda.
3. Configure block visibility as you would for any block, and save the layout.

The block renders the Sessionize widget using the ID and style you set above.

## A note on the third-party embed

The block works by loading Sessionize's embed script, so the agenda content and its
assets are fetched from Sessionize's servers at view time. That means the display
depends on Sessionize being reachable, and you are trusting that provider to serve
the widget — the data involved is public event information. There is nothing
sensitive to configure here beyond the embed ID.
