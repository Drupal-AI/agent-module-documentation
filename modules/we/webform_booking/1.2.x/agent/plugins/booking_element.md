<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `webform_booking` element & availability model

Webform Booking implements the **Webform** element plugin type (it defines no plugin type of its own).

## Element
- `Plugin/WebformElement/WebformBooking` — `@WebformElement(id="webform_booking", label="Booking",
  category="Booking")`, extends `Drupal\webform\Plugin\WebformElementBase`.
- Render element `Element/WebformBooking` produces the day/slot picker markup consumed by the JS + AJAX
  endpoints.
- Add it in Webform UI (Add element → Booking). Slot/day rules are stored on the element definition and
  read back through `getElementsDecodedAndFlattened()[$element_id]`.

## Availability computation (services / value objects)
| Class | Role |
|---|---|
| `SlotAvailability` (`webform_booking.slot_availability`, args `@database`, `@datetime.time`) | Given a webform + posted values, computes which days/slots are free vs taken from existing submissions; `valuesAvailable()` gate used before create/capture. |
| `SlotGrid` | Builds the grid of slots for a day. |
| `SlotDayFilter` | Filters selectable days. |
| `BookingValue` | Parses/normalises a submitted booking value (date/time/slots). |

## Flow
1. Picker loads → JS calls `/get-days/...` then `/get-slots/...` (access = open webform + this element).
2. On submit (and, if paid, before PayPal capture) `SlotAvailability::valuesAvailable()` re-checks the
   slot is still free, so a concurrent booking is refused rather than double-booked.
3. Value is stored on the Webform submission; `view webform booking input` gates viewing the raw input.

To customise available days/slots, configure the element (opening hours, slot length, capacity) in the
Webform element settings; there is no separate config entity.
