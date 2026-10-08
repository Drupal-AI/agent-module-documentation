# Place & configure a contact block

No dedicated admin page — everything is in **Structure → Block layout**
(`/admin/structure/block`).

1. First create/adjust contact forms at **Structure → Contact forms**
   (`/admin/structure/contact`) and their fields via *Manage fields*.
2. In Block layout, **Place block** in a region and pick **Contact block**.
3. Block settings (`ContactBlock::blockForm`):
   - **Contact form** (`contact_form`, required) — which contact form to embed. Defaults to
     `contact.settings:default_form`.
   - **Form display** (`form_display`) — which `contact_message` form mode to render
     (default `default`). Extra form modes appear here automatically.
4. Add the usual block visibility conditions (pages, roles, content type) as needed.

## Stored config (block config schema `block.settings.contact_block`)
```yaml
contact_form: feedback        # contact form id
form_display: default         # contact_message form mode
```
The block declares a config dependency on the selected contact form, so it exports/imports
together. If the referenced form is later deleted, the block returns *access forbidden*.

## Personal contact form
Selecting the personal form makes the block appear **only** on pages with a `user` route
parameter (e.g. `/user/{user}`); the recipient is that user and access reuses core's
`access_check.contact_personal`. See [plugins/contact-block.md](../plugins/contact-block.md).
