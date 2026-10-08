<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
E-mail Formatter is a single field formatter for core's Email field that renders the address as an optional `mailto:` link with truncation, a text/HTML prefix, and an optional Font Awesome icon.

---

Core's Email field ships one formatter that renders the stored address as a plain `mailto:` link. E-mail Formatter (plugin id `email_formatter`, label "E-mail formatter (with options)") replaces it with a configurable one, chosen per view-display on *Manage display*. Its six settings let you: toggle whether the address is wrapped in a `mailto:` link at all; truncate the visible address to a character count and append an ellipsis; prefix the address with escaped custom text; prefix it with admin HTML; and prefix it with one of nine hard-coded Font Awesome envelope/reply/inbox icons that can itself be a `mailto:` link. Everything is display-only — the module has no routes, permissions, services, Drush commands, or site-wide config; each field's choices are stored in that view-display's `settings` and described by `config/schema/email_formatter.schema.yml`. The Font Awesome icon output only appears if a Font Awesome library/module is installed to supply the `fas fa-*` classes.

---

- Turn a core Email field into a clickable `mailto:` link on the entity display.
- Show an Email field as plain text with no link (uncheck *mailto*).
- Truncate a long address to a set number of characters, ending with an ellipsis.
- Set truncation to blank or 0 to disable truncation and show the full address.
- Prefix the address with custom label text such as "Email: ".
- Prefix the address with a Font Awesome envelope icon.
- Choose among envelope, envelope-square, envelope-open, envelope-open-text, paper-plane, reply, reply-all, inbox, or mail-bulk icons.
- Make the Font Awesome icon itself a `mailto:` link to the address.
- Use a different formatter configuration per view mode (teaser vs. full).
- Configure it entirely in the Field UI via the format's gear/cog settings.
- Export the per-field settings in the view-display config for deployment.
- Apply it to any Email field on nodes, users, taxonomy terms, or other fieldable entities.
- Present a staff/contact directory's email addresses consistently across a site.
- Shorten addresses that would otherwise break a narrow table column.
- Combine a text prefix with an icon for a labelled contact line.
- Keep the `mailto:` link on the icon while showing the address as plain text.
- Read the current choices at a glance from the *Manage display* settings summary line.
- Swap back to core's plain Email formatter at any time without data changes.
- Style the rendered output further with your theme's CSS.
- Validate the saved formatter settings against the module's config schema.
