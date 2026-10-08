# Configuration

Webform Booking has two places you configure things: a **global settings form**
(PayPal credentials, currency, default country) and the **booking element**
itself, which you add and tune inside each Webform. This page covers the global
settings and permissions; the per-form booking rules live on the element.

## Permissions

Set these first under **People → Permissions**. All three are restricted
permissions meant for trusted staff roles:

- **Manage webform booking** (`manage webform booking`) — required to open the
  global settings form below.
- **View webform booking input** (`view webform booking input`) — required to see
  the raw booking value on a submission.
- **Cancel all webform bookings** (`cancel all webform bookings`) — lets staff
  cancel any booking without the per-submission token that customers use.

The public-facing actions — loading availability, paying, and a customer
cancelling their own booking — are *not* tied to a role. They rely on core's
*access content* plus module access checks that verify the specific
form/element/order and, for cancellation, a per-booking token. That is by design
so anonymous visitors can book.

## Global settings form

Go to **Configuration → Web services → Webform Booking**
(`/admin/config/services/webform-booking`). The form writes to the
`webform_booking.settings` configuration:

- **PayPal client id** (`paypal_client_id`) — the client id of your PayPal REST
  application.
- **PayPal client secret** (`paypal_client_secret`) — the matching REST secret.
  **While this is empty, payment is inactive and every booking form is free.**
  Fill it in to switch bookings to paid.
- **PayPal environment** (`paypal_environment`) — choose **sandbox** for testing
  or **live** for real charges.
- **Currency** (`currency`) — the ISO currency code used for charges (for example
  `USD`, `EUR`).
- **Default country** (`default_country`) — the country pre-selected on the
  booking form.

> **Handling the PayPal secret safely.** Treat the client secret like any other
> credential — avoid committing it to version control. If you manage secrets
> through environment variables (for example with DDEV's dotenv), set the value
> in the environment and enter it here rather than hard-coding it in exported
> config.

Click **Save configuration** to store the settings.

## The booking element

Availability is configured per form, not globally. Add a **Booking** element to a
Webform (Webform UI → **Add element** → **Booking**) and set its opening days,
slot length and capacity in the element settings. Those rules are stored on the
element definition — there is no separate config entity to manage.

When a visitor books, the module fetches available days and slots live as they
pick a date, then re-checks availability on submit (and again before capturing a
PayPal payment) so a slot that was taken in the meantime is refused rather than
double-booked. For paid forms the charge is always recomputed on the server, the
PayPal capture is verified and recorded in a ledger so an order can't be replayed,
and create-order requests are flood-limited per IP.

## Cancellation

Each booking can be cancelled at
`/webform_booking/{webform}/submissions/{submission}/cancel_booking`. Customers
reach it through a tokenised link (the token authorises cancelling that one
booking, no account required); staff holding *cancel all webform bookings* can
cancel without the token.
