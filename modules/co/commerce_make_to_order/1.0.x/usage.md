<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Make-to-Order adds a production workflow for made-to-order Commerce items.

---

Commerce Make-to-Order adds make-to-order (MTO) production workflow management to Drupal Commerce: MTO orders have their own entity type, states/transitions (via State Machine), numbering, logging, and analytics — suitable for businesses that manufacture items after purchase rather than shipping from stock.

It exposes a rich permission set covering administration, view/create/update/delete (any/own), transitions, cancellation, analytics, and notes — grant the `any`/`administer`/`transition` permissions only to production staff. Depends on core `user`, Commerce (`commerce`, `commerce_order`, `commerce_number_pattern`, `commerce_log`), and `state_machine`; supports Drupal 10 and 11.

---

- Manage make-to-order production.
- Provide an MTO order entity.
- Model states/transitions via State Machine.
- Number MTO orders.
- Log MTO activity.
- Provide MTO analytics.
- Gate admin with `administer mto orders`.
- Separate view/create/update/delete any vs own.
- Gate transitions with `transition mto orders`.
- Gate cancellation and notes.
- Restrict `any`/`administer` to production staff.
- Depend on Commerce order/log/number_pattern.
- Depend on `state_machine` and core `user`.
- Support Drupal 10 and 11.
- Track production workflow.
- Handle manufacture-after-purchase.
- Manage MTO order lifecycle.
- Report MTO analytics.
