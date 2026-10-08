Block Title Link lets you turn the title (label) of any configured block into a link, set via a small settings group added to the block configuration form. It requires no configuration page of its own and stores everything in the block's third-party settings.

---

The module is a single `.module` file. `hook_form_block_form_alter()` adds a "Block Title Link Settings" details group (in the block form's `advanced` region) with four fields stored under the block's `third_party_settings.block_title_link`: an `entity_autocomplete` URL field (target type `node`, validated by core `LinkWidget::validateUriElement`, so it accepts node references or generic internal/external URIs), a link title (tooltip) text field, a link target `<select>` (`_blank`/`_self`/`_parent`/`_top`), and an enable checkbox. `hook_preprocess_block()` then, for any block where `title_link_enable` is set, replaces the `label` variable with a `#type => 'link'` render element built from `Url::fromUri()` on the stored URL, applying the chosen target and title attributes. It depends on core `block` (and uses the `link` module's widget class for URI validation/display). There is no config schema, no permissions of its own (it inherits the block admin form's `administer blocks` gate), no services, and no Drush.

---

- Make a block's title clickable, linking to a node.
- Link a block title to an internal path (e.g. `/about`) via the URI field.
- Link a block title to an external URL.
- Open a block title link in a new tab (`_blank` target).
- Set the block title link to open in the same window or a named frame (`_self`/`_parent`/`_top`).
- Add a tooltip (title attribute) to a linked block title.
- Turn a "Latest news" block heading into a link to the news listing page.
- Link a promo/CTA block title to a landing page.
- Toggle the title link on or off per block without removing the configured URL.
- Use node autocomplete to pick the target node by name rather than typing a path.
- Link a footer block title to a contact or legal page.
- Make a menu-teaser block title link to the section's overview page.
- Provide a linked heading for a Views block that points at the full View page.
- Keep the block markup otherwise unchanged (only the label becomes a link).
- Configure the link entirely within the standard block placement form (no extra admin page).
