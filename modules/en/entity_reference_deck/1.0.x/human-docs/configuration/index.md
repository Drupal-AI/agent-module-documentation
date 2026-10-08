# Configuration

Entity Reference Deck is configured in two places: a **global settings form** for
site‑wide defaults, and each field's **form‑display widget settings** for how a
particular reference field behaves. There is no new content type to create.

## Open the global settings form

1. Log in as a user with permission to administer the module's settings (an
   administrator by default).
2. Go to **Configuration → Content authoring → Entity Reference Deck**.

On this form you set site‑wide defaults for the deck:

- **Action groups** — how the pluggable toolbar actions (for example moderation,
  usage, and diff, supplied by the feature submodules you enabled) are grouped and
  presented on cards.
- **Meta items** — the meta information displayed on each card, such as status
  tags and usage badges.
- **Card defaults** — the baseline card presentation applied across reference
  fields, before any per‑field overrides.

Only actions from submodules you have enabled appear here — the core module works
on its own, and Diff, Usage, Moderation, and Paragraphs Library options show up
once their respective feature submodules are on.

## Save the global settings

Click **Save** on the settings form. These defaults then apply to fields that use
an ER Deck widget.

## Configure a field's widget

The per‑field behaviour is set on the **form display**, not on this settings page:

1. Go to **Structure → Content types → *(type)* → Manage form display**
   (`/admin/structure/types/manage/{type}/form-display`), or the equivalent
   Manage form display for another entity type.
2. For the entity reference field you want to turn into a deck, set its **Widget**
   to an **ER Deck host widget** — the Entity Browser host
   (`entity_reference_deck_eb`) or the Paragraphs host
   (`entity_reference_deck_paragraphs`), depending on which host submodule you
   enabled.
3. Adjust the widget's settings, then save.

## Optional theme skin

If you use the **Gin** admin theme, enable the **Deck Gin** submodule
(`entity_reference_deck_gin`) so the deck's `--erdeck-*` design tokens are remapped
to match Gin — no configuration is needed beyond enabling it.

## Verify

Edit a piece of content that has a deck‑configured reference field: the referenced
items should render as cards with the toolbar actions and meta items you set up on
the global settings form.
