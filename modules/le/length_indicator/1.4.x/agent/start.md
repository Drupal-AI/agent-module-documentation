<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Length Indicator — agent index

Adds a per-widget **"Length indicator"** checkbox plus three numbers (Optimum minimum,
Optimum maximum, Tolerance) to core text widgets. When on, a colored bad/ok/good bar renders
under the field on edit forms. No settings form, no configure route, no permissions, no Drush,
no plugins. Its only persistent state is a **third-party setting** on a text widget in an
`entity_form_display` config entity.

- **Turn the indicator on for a field / read where it is stored / the three settings** →
  [configure/length-indicator.md](configure/length-indicator.md)
- **How it works (hooks, supported widgets, the segment-geometry service) ** →
  [api/mechanism.md](api/mechanism.md)

Key fact: the setting lives at
`core.entity_form_display.<entity>.<bundle>.<form_mode>` →
`content.<field>.third_party_settings.length_indicator` with
`indicator: true` and `indicator_opt: {optimin, optimax, tolerance}`, and the checkbox only
appears for the `string_textfield` and `string_textarea` widgets.
