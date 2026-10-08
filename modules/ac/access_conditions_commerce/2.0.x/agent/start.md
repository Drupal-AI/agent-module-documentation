<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Access Conditions Commerce — agent orientation

Commerce checkout panes whose visibility is driven by Access Conditions access models.

Structure:
- `src/AccessConditionsCommerceCheckoutPaneTrait.php` — the shared logic: `defaultConfiguration()`, config form adding an `access_models` entity_autocomplete, and `isVisible()` that loops models and calls `access_conditions.access_checker`.
- `modules/checkout|payment|promotion/src/Plugin/Commerce/CheckoutPane/*` — thin subclasses of core Commerce panes using the trait (all `default_step = "_disabled"`).

Security posture: sound. Purely display/visibility; delegates decisions to the reviewed AccessChecker. No routes, no mutation. `PaymentProcess` preserves core paid/free guards.

To extend: subclass another Commerce pane and `use AccessConditionsCommerceCheckoutPaneTrait`.
