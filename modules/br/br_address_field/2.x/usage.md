<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Brazilian Address Field adds a structured Brazilian postal-address field whose widget can auto-fill the street, neighborhood, city and state from an entered CEP (postal code) via the ViaCEP web service.

---

Brazilian addresses follow the Correios structure — logradouro (thoroughfare), número, complemento, bairro, cidade, estado (UF) and CEP (postal code). This module packages all of that into one field type (`br_address_field_type`) that stores the seven parts in a single field, a widget (`br_address_widget_type`) that renders a textfield per part plus a 27-state select, and nine formatters for displaying either the whole address or an individual part. When enabled in the widget settings, typing a CEP fires an AJAX lookup against the public ViaCEP service and populates thoroughfare, neighborhood, city and state automatically. The widget lets you mark each part required independently and optionally wrap the inputs in a collapsible container; the plain formatter can render the state as its two-letter initials or its full name. It attaches a small CSS library and requires the Mask module (for input masking). There is no dedicated admin settings page — everything is configured through Drupal's normal Manage fields / Manage form display / Manage display screens on the entity bundle.

---

- Add a structured Brazilian address to any content type, user, taxonomy term, or other fieldable entity.
- Capture CEP, thoroughfare, number, complement, neighborhood, city and state in one field.
- Let editors type a CEP and have the street, neighborhood, city and state fill in automatically.
- Turn the CEP auto-fill off (`Fill address` setting) and require editors to type every part by hand.
- Store the state as a validated two-letter UF chosen from a 27-option select (AC…TO).
- Mark the postal code, thoroughfare, number, complement, neighborhood, city and state required individually.
- Wrap the address inputs in an open `details` container, or render them as a plain `div`, per the `Show address container` setting.
- Display the full formatted address using the `Brazilian address` (plain) formatter and its Twig template.
- Show the state either as its initials (`SP`) or full name (`São Paulo`) via the plain formatter's `display_state` setting.
- Output just the city with the `City` formatter for teaser or list displays.
- Output just the neighborhood, number, complement, or thoroughfare with their dedicated single-part formatters.
- Show only the postal code with the `Postal Code` formatter.
- Show the state's two-letter initials with the `State` formatter or its full name with the `State full` formatter.
- Override `templates/br-address-field.html.twig` in your theme to change how the full address renders.
- Restyle the address block by overriding the module's `br_address_field/theme` CSS library.
- Collect shipping or billing addresses for Brazilian e-commerce or membership sites.
- Store a company or branch address on a node bundle with a single field.
- Reduce data-entry errors by pre-filling address parts from an official CEP source.
- Provide a consistent, machine-readable address structure for exports, views, or downstream integrations.
- Attach the field to the user entity so members maintain their own Brazilian address.
- Support multi-part address search or filtering by exposing individual parts through their formatters.
- Localize address entry for Portuguese-speaking Brazilian editors with native part labels.
