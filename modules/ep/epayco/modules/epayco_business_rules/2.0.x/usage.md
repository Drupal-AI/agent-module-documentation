<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
ePayco Business Rules integrates ePayco transactions with the Business Rules module.

---

ePayco Business Rules (`epayco_business_rules`) connects the ePayco project to the Business Rules module. It adds a
"Fetch payment" action that queries ePayco for a transaction's information and stores it into an "ePayco payment
info" variable, and a "Transaction response" reacts-on event that fires whenever the base module dispatches its
ePayco transaction-response event. Site builders can therefore build no-code rules that react to ePayco payments —
for example fetch and inspect payment data when a customer returns, using the reference from a custom value, a path
argument, a query string, or the transaction event itself. Requires the base `epayco` module and `business_rules`;
note the module's info.yml declares core `^8.7.7 || ^9` only.

---

- React to ePayco transactions with no-code Business Rules.
- Trigger a rule on the "Transaction response" event.
- Fetch ePayco payment/transaction information inside a rule.
- Store fetched payment data in an "ePayco payment info" variable.
- Read the transaction reference from a fixed/custom value.
- Read the reference from a path argument (N-th path fragment).
- Read the reference from a query-string parameter.
- Read the reference from the transaction-response event argument.
- Access individual payment fields (normalized `key->subkey` structure) in later actions.
- Send a notification when an ePayco payment succeeds.
- Update an entity based on ePayco payment status.
- Log or record ePayco transaction outcomes.
- Branch rule logic on the payment response code.
- Combine ePayco data with other Business Rules actions and conditions.
- Build donation-page follow-up flows around ePayco returns.
- Inspect ePayco payment data during development without custom code.
