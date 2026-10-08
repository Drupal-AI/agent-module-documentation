# Configuration

The configurable part of LocalGov Utilities is the **LocalGov Character Counter**
submodule. It gives you one form that sets up Textfield Counter for your LocalGov
title and summary fields, so you don't have to configure the counter field by field
yourself.

## Open the settings form

1. Enable the **`localgov_char_count`** submodule (see
   [Installation](../installation/index.md)).
2. Log in as a user who can administer site configuration.
3. Go to **Configuration → Content authoring → LocalGov Character Count**, or
   navigate directly to `/admin/config/content/localgov-char-count`.

## Settings

On this form you configure how character counting behaves:

- **Maximum title length** — the recommended maximum number of characters for the
  **title** field. This drives the count shown to editors as they type.
- **Maximum summary length** — the recommended maximum number of characters for the
  **summary** field.
- **Count message text** — the wording displayed alongside the running count (for
  example the text that accompanies the "characters remaining" figure). Set it to
  whatever reads clearly for your editors.
- **Fields to apply counting to** — choose which title and summary fields the
  character counter should be added to. Only the fields you tick get the live count.

Click **Save** to store your settings. The counter is then configured on the chosen
fields via Textfield Counter.

## Verify it

Edit a piece of content whose title or summary field you selected. As you type, a
live character count should appear beneath the field, using the maximum length and
message text you set here.
