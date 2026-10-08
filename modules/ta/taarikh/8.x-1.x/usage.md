<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Taarikh lets editors enter and sites display dates in the Hijri (Islamic) calendar, working on top of core `datetime`/`datetime_range` fields.
---
It provides a `TaarikhDefaultWidget` field widget and `TaarikhDefaultFormatter` field formatter, plus custom form elements (`TaarikhDate`, `TaarikhDatetime`) for the Hijri date entry/display. Calendar conversion is handled through a plugin system: the `TaarikhAlgorithm` annotation and `AlgorithmPluginManager` (service `plugin.manager.taarikh_algorithm`) let alternative Gregorian↔Hijri conversion algorithms be swapped in; a `FatimidAstronomical` algorithm plugin ships as the default implementation (extending `TaarikhAlgorithmPluginBase`).

The module is a pure field/UI layer with no routes, permissions, controllers or outbound network calls, so it has no request-facing attack surface; its only dependency is core `datetime`. Setup is: add a datetime field, then select the Taarikh widget on the form display and the Taarikh formatter on the view display. Developers can add new conversion algorithms by implementing the `TaarikhAlgorithm` plugin interface.
---
- Add a datetime field and set its form widget to the Taarikh Hijri widget.
- Display an existing datetime field in the Hijri calendar via the formatter.
- Let editors pick a Hijri date for event content.
- Show publication dates in Islamic-calendar form on articles.
- Enter birth dates in the Hijri calendar.
- Use the `TaarikhDate` element in a custom form.
- Use the `TaarikhDatetime` element for date-and-time entry.
- Swap the conversion algorithm by selecting a different TaarikhAlgorithm plugin.
- Implement a custom Gregorian↔Hijri algorithm plugin.
- Register a new algorithm via the `@TaarikhAlgorithm` annotation.
- Use the shipped Fatimid Astronomical conversion algorithm.
- Combine Hijri display with core datetime storage.
- Format range fields with Hijri start/end dates.
- Provide Hijri date entry for Arabic-language content.
- Resolve the algorithm plugin manager service in custom code.
- Theme the Hijri date output through the formatter.
- Localize month names for the Islamic calendar.
- Keep Gregorian storage while presenting Hijri to users.
- Add Hijri date support to an events or calendar content type.
