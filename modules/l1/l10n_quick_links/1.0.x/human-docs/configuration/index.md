# Configuration

Localization quick links works as soon as it is enabled and the widget permission
is granted. The settings form only lets you refine *where* the widget appears and
*which* entity fields it tracks.

## Open the settings form

1. Log in as a user with the **Administer languages** permission.
2. Go to **Configuration → Regional and language → User interface translation →
   Localization quick links**, or navigate directly to
   `/admin/config/regional/translate/l10n-quick-links`.

## What you can configure

- **Disable the widget on certain pages.** If the on‑page widget gets in the way on
  particular paths — a checkout flow, a heavily interactive admin screen, or any
  page where you never translate — you can exclude those pages so the **Translate
  page** button and widget don't load there.
- **Track entity type fields.** The module tracks rendered entity fields with
  sensible defaults out of the box. Use this section to adjust which entity types
  and fields are surfaced in the widget, so translators see the fields that matter
  for your content model and aren't distracted by ones they never translate.

## Save

Click **Save configuration**. Changes take effect the next time a translator opens
a page and toggles the widget.
