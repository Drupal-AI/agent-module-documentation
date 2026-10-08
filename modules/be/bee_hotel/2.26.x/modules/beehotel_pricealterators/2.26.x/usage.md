Bee Hotel Price Alterators ships the concrete pricing plugins (occupants, seasons, sliders, consecutive nights, check-in time, special nights) that plug into the Bee Hotel price chain.

---

Enable this submodule to get a library of ready-made PriceAlterator plugins, each with its own admin settings form at /admin/beehotel/pricealterator/alterators/<name> (permission 'administer bee_hotel'). The plugins are discovered by beehotel_pricealterator's manager and applied per night by the price resolver. It also installs a special_night content type (with fields field_type, field_polarity, field_nights, field_alteration) used by the SpecialNights alterator, and adds a field_checkin_time string field to the bee commerce_order_item type used by CheckinTime. Depends on range_slider for the slider UIs.

---

- Charge more (or less) based on the number of occupants per night.
- Apply low/high/peak seasonal rates from the season calendar.
- Nudge every price up or down with a store-wide percentage global slider.
- Discount longer stays with the consecutive-nights alterator.
- Price by booking lead time (days before check-in).
- Sell paid check-in time slots and add a one-time late-check-in fee to the order.
- Add event/premium pricing for specific dates via special_night nodes.
- Enforce one-night-only, Saturday-night-only or Sunday-check-in rules.
- Configure each rule independently from its own admin form.
- Clone the module as a starting point for a bespoke set of pricing rules.
- Combine multiple alterators; the chain applies them by weight and averages nightly prices.
