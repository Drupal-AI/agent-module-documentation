<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Cafe Outlet Billing is a lightweight point-of-sale style tool: a form where a cashier enters line items (name, quantity, price), and a controller that renders those items into a printable PDF invoice using TCPDF (with the site name and email in the header).

Use it as a minimal in-house billing/receipt generator for a small cafe outlet.
---
Enable with Composer (`composer require drupal/cafe_outlet_billing`, pulls `tecnickcom/tcpdf`) then `drush en cafe_outlet_billing` (depends on core `field` and `views`, PHP >= 8.1). The billing form is at `/billing-form` (route `cafe_outlet_billing.form`); the PDF is produced at `/generate-bill/{items}/{cashier_id}` (route `cafe_outlet_billing.generate_bill`) where `{items}` is a URL-encoded JSON array of line items.

Both routes use the `access content` permission. The form (`src/Form/BillingForm.php`) lets you add/remove rows and defaults the cashier id to the current user; the controller (`CafeOutletBillingController::generateBill()`) decodes the JSON, sums totals, and streams a `application/pdf` response.
---
- Generate a printable PDF invoice for a cafe order.
- Enter line items (name/qty/price) on a billing form.
- Add and remove item rows dynamically via AJAX.
- Auto-calculate per-line and grand totals.
- Stamp the site name and email on each invoice.
- Produce a receipt a customer can download or print.
- Record the cashier id on the generated bill.
- Use TCPDF to render the invoice server-side.
- Serve the bill inline as an application/pdf response.
- Run a minimal point-of-sale flow inside Drupal.
- Prototype a small-outlet billing workflow.
- Date-stamp each generated invoice.
- Build invoices from a URL-encoded JSON item list.
- Hand a printed receipt to a walk-in customer.
- Provide a simple no-inventory billing sheet.
- Generate ad-hoc bills without a full commerce stack.