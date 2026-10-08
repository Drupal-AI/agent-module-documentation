Bee Hotel Utils provides the shared, dependency-free utility services (dates, units, commerce, currency) that the rest of the Bee Hotel suite builds on.

---

This submodule is enabled automatically as a hard dependency of bee_hotel and beehotel_pricealterator. It ships no routes, permissions or UI - only four services in src/: Dates, BeeHotel, BeeHotelUnit and BeeHotelCommerce. Other modules inject these to normalise search-form dates, decide whether a node is a bookable unit, read maximum occupancy, look up available units, resolve the current store and currency, and format currency amounts. Because it never depends on other Bee Hotel modules it can be reused as a stable low-level layer.

---

- Normalise free-text Litepicker date ranges into structured check-in/check-out/nights arrays.
- Compute Easter and season-related date helpers for pricing.
- Detect whether a given node is a Bee Hotel bookable unit (isThisNodeBeeHotel).
- Read a unit's maximum occupancy from its Commerce product variations.
- Query which units are available for a set of dates.
- Resolve the current Commerce store and its currency/symbol.
- Provide day-array helpers (ISO 8601, timestamps, day-before/day-after) used by the calendar and pricing.
- Share one currency/format helper so all Bee Hotel modules render amounts consistently.
- Act as a stable, dependency-free base layer other Bee Hotel submodules inject.
- Avoid duplicating date/unit logic across the booking form, price resolver and vertical calendar.
