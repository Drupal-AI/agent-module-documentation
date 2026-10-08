<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Add To Calendar — agent index

Renders an "Add to Calendar" button (iCalendar / Google / Outlook / Outlook Online / Yahoo)
beside date fields, driven by the external **addtocalendar.com** JS library. No configure
route (`configure: null`), no permissions, no Drush.

- **Add the button to a datetime field, or add the standalone field type — settings keys and where config is stored** →
  [configure/button.md](configure/button.md)
- **Alter the emitted event values in code** → [hooks/field-alter.md](hooks/field-alter.md)

Key facts:
- Two mechanisms: (1) a **third-party formatter setting** `addtocalendar` on core `datetime` /
  `daterange` formatters (tick "Show Add to Calendar"); (2) a dedicated **field type**
  `add_to_calendar_field` (widget `add_to_calendar_widget_type`, formatter `add_to_calendar`).
- The formatter setting is stored on the **entity view display**:
  `core.entity_view_display.<entity>.<bundle>.<mode>` →
  `content.<field>.third_party_settings.addtocalendar.addtocalendar_show: 1` (plus
  `addtocalendar_settings`).
- Event data is emitted as hidden `<var>` markup; the library
  `//addtocalendar.com/atc/1.5/atc.min.js` (attached via the `addtocalendar/base` library) turns
  it into the button. Styles: `addtocalendar/blue`, `addtocalendar/glow_orange`, or none.
- Service `addtocalendar.apiwidget` (`Drupal\addtocalendar\AddToCalendarApiWidget`) builds the
  widget render array; it is used internally by the `add_to_calendar` formatter.
