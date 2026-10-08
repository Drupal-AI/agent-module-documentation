<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Phone Label adds a distinct "Labelled telephone number" field type that stores an optional label next to a core telephone number, so a value can be shown as "Reception" rather than "+44 20 7946 0958".

---

Core's `telephone` field stores a number and nothing else, which becomes ambiguous the moment an entity carries more than one number (a switchboard and a direct line, a daytime and an out-of-hours contact). Phone Label solves this by subclassing core's telephone field type into a new type, `phone_label`, that keeps a `title` string column beside the number. It ships exactly three plugins: the field type `PhoneLabelItem` (adds the `title` property and a per-field "Allow label override" setting of Disabled / Optional / Required), the widget `PhoneLabelDefaultWidget` (extends core's telephone widget with a Label textfield and a label-placeholder setting), and the formatter `PhoneLabelFormatter` ("Telephone link with label") that outputs each value as a `tel:` link using the label as the link text, falling back to the number when no label was entered.

Because it is a separate field type rather than a third-party setting on core's telephone field, adding a label is a choice made when the field is created — there is no in-place upgrade of an existing `telephone` field, so converting one means adding a new field and migrating values. The module has no configuration page, no routes, no permissions, and no services; its whole surface is the three field plugins and a config schema. Note the field type's declared `default_formatter` is core's `basic_string`, so to get the `tel:` link with the label you select the "Telephone link with label" formatter on Manage display.

---

- Attach an optional human-readable label to a telephone number.
- Distinguish a switchboard number from a direct line on the same entity.
- Store several labelled numbers on one entity via a multi-value field.
- Render "Reception" or "Sales" as link text instead of a bare number.
- Add a Label input above the number in the edit form.
- Make the label Disabled, Optional, or Required per field via "Allow label override".
- Set placeholder hint text for the label input on the widget.
- Output each number as a clickable `tel:` link on the display.
- Fall back to showing the number itself when no label is entered.
- Avoid creating a Paragraph type just to pair a label with a phone number.
- Avoid one separate field per phone number.
- Reuse core telephone's number storage and validation behaviour.
- Add labelled phone numbers to a node, user profile, or taxonomy term.
- Add labelled phone numbers to any fieldable entity type.
- Keep a label-per-value on multi-value phone fields (widget labels each row).
- Migrate content from core telephone fields into labelled ones.
- Select "Telephone link with label" as the formatter on Manage display.
- Keep configuration minimal — no admin settings form to manage.
- Present a contact block where each number is titled and dialable.
- Enforce a required label so editors always name each number.
