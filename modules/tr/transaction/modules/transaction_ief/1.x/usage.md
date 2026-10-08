<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bridges the Transaction framework and **Inline Entity Form**, adding a widget that lets a transaction be created directly from the form of the entity it targets, rather than on a separate transaction screen.

---

The parent Transaction module models logged operations against entities, but by default running one means going to a transaction route. That is a context switch: you are editing an asset, and to record a check-out you leave the asset form. For the common case where the transaction belongs to the thing you are already editing, that friction is unnecessary.

This submodule removes it by using Inline Entity Form. It provides an IEF widget so a new transaction can be created inline, on the target entity's own edit form — record the operation where you are, without navigating away. It is the ergonomic layer on top of the framework: the access model, the logging and the transactors are all the parent's; this only changes where the transaction is created.

It depends on both **Transaction** and **Inline Entity Form**, and is only useful when both are in play. Enable it when your transactional workflow wants operations captured alongside the entity rather than on their own screens.

---

- Create a transaction from the entity form.
- Record an operation without leaving the page.
- Add transactions inline on a target entity.
- Use an Inline Entity Form widget for transactions.
- Reduce context switching in a workflow.
- Capture a check-out on the asset form.
- Keep the parent's access model.
- Keep the parent's logging.
- Add a transaction widget to an edit form.
- Streamline a transactional workflow.
- Pair Transaction with Inline Entity Form.
- Create operations where they belong.
- Avoid a separate transaction screen.
- Enable when both modules are used.
- Author a transaction inline.
- Keep transactors defined in the parent.