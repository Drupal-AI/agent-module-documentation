<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Profile Pane adds a Drupal Commerce checkout pane that lets a customer create or edit one of their Profile entities without leaving the checkout flow.

---

Install it with `composer require drupal/commerce_profile_pane` and enable it (`drush en commerce_profile_pane`); it needs **Commerce**, **Commerce Checkout**, **Profile**, and **Inline Entity Form**. For every Profile type you define (except Commerce's built-in `customer` type) the module derives a checkout pane called "*&lt;type&gt; profile form*". The pane is **disabled by default**, so nothing changes until you place it: edit a checkout flow at **Commerce → Configuration → Orders → Checkout flows** (`admin/commerce/config/checkout-flows/manage/default`), drag the pane out of the *Disabled* region into a real step such as *Order information* — but **not** the `login` step, which has no submit button — then set its **Form mode** (which profile form mode to render) and **Display label** (the fieldset heading, default `Edit profile`) and save. In checkout the pane loads the current user's profile of that type via `loadByUser()`, or builds a new one owned by them if they have none, and embeds it as an inline entity form that saves when the customer advances to the next step. The pane only appears when the user has permission to create or update that profile, so grant the Profile module permissions (`create <type> profile`, `update own <type> profile`) to the appropriate roles. Because the data lives on a Profile entity rather than on order fields, it persists across orders and a returning customer is not asked again; treat anything you collect here as personal data that needs a reason, a retention position, and a way for the customer to review it, and keep in mind that every extra checkout field costs conversions.

---

- Let customers edit a Profile entity during Commerce checkout.
- Collect extra customer information inline in the checkout flow.
- Add a "dietary requirements" profile to a food-ordering checkout.
- Capture a delivery instruction as a reusable profile field.
- Record a membership or loyalty number at checkout.
- Gather a marketing/communication preference during checkout.
- Reuse profile data across orders so returning customers aren't asked twice.
- Store data on the customer's profile rather than on each order.
- Expose one checkout pane per Profile type you define.
- Choose which profile form mode the pane renders.
- Set a custom fieldset label (default "Edit profile") for the pane.
- Place the pane in a chosen checkout step (avoiding the login step).
- Keep the pane hidden from users who lack profile create/update access.
- Create a new profile automatically for a user who has none.
- Edit a user's existing profile of a given type in place.
- Let a customer view and change their own profile data at checkout.
- Enable multiple profile panes (one per type) in a single flow.
- Skip the `customer` profile type, which Commerce core already handles.
- Audit the personal data your checkout collects and retains.
- Justify each field before adding it to the checkout profile form.
- Measure the conversion cost of each added checkout field.
- Remove profile fields that change nothing at checkout.
- Document the pane's configuration for a store's build.
- Re-verify the pane's behaviour after a Commerce or Profile upgrade.
