<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Telephone provides the `telephone` field type — a length-validated phone-number field with a text-entry widget and a `tel:` link formatter. It is core's Telephone module continued as a contrib project for Drupal after core stopped shipping it.

---

The module defines the `telephone` field type (`TelephoneItem`, a `varchar(256)` single-value string), a `telephone_default` widget (an HTML5 `<input type="tel">` with an optional placeholder), and a `telephone_link` formatter (`TelephoneLinkFormatter`) that renders the stored number as a clickable `tel:` link — the behaviour that makes a phone number tappable on a mobile device. The field's only validation is a 256-character maximum length; it does not enforce a phone-number pattern, so any string up to that length is accepted. Three OO hook implementations in `src/Hook/TelephoneHooks.php` round it out: `hook_help()` for the module help page, `hook_field_formatter_info_alter()` (which also lets core's plain `string` formatter display the field), and `hook_field_type_category_info_alter()` (which places the field type in the correct field-type category and attaches its icon library). A small CSS library (`telephone.icon.theme.css`) supplies the field-type icon shown in the *Add field* UI, and `config/schema/telephone.schema.yml` covers the widget/formatter settings and default value. Because the machine name, field-type id, and widget/formatter ids are all unchanged from core, a site can require this project and every existing field, display and exported config keeps working untouched.

---

- Store a phone number on a content type with proper field semantics.
- Render numbers as tappable `tel:` links on mobile and assistive devices.
- Keep telephone fields working after core stops shipping the module.
- Add a contact number to a staff or author profile.
- Collect a phone number on a user account or registration.
- Include a phone number in a directory or listing entry.
- Show a click-to-call link in a teaser or card.
- Replace the link text with a custom label (e.g. "Call us") via the formatter title setting.
- Provide a phone field for a custom or webform-backed entity.
- Keep field configuration unchanged when upgrading Drupal.
- Add separate mobile and landline fields to an organisation record.
- Give editors a placeholder hint (sample format) in the entry widget.
- Migrate telephone data from Drupal 7 telephone fields.
- Include phone numbers in exported entity data.
- Expose telephone fields through JSON:API or REST.
- Display a click-to-call button on a service or contact page.
- Keep the field type visible in the correct *Add field* category with its icon.
- Enforce a maximum length on stored phone strings.
- Reference the number in tokens, Views and Twig templates.
- Provide a consistent phone field across many content types.
- Retire ad-hoc plain-text fields used for phone numbers.
- Display the number as plain text using core's `string`/`basic_string` formatter instead of a link.
