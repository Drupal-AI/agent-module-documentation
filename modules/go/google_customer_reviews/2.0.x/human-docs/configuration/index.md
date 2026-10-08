# Configuration

Configuration has three parts: enter your merchant ID and survey settings, confirm
the checkout pane, and (optionally) place the badge block.

## 1. Enter your merchant settings

1. Get your **merchant ID** from the
   [Google Merchant Center](https://merchants.google.com/) — it's shown in the upper
   right of the screen.
2. Go to **Configuration → Web services → Google Customer Reviews**
   (`/admin/config/services/google-customer-reviews`).
3. Enter your **Merchant ID**.
4. Configure how the **opt‑in** should appear.
5. Set the **average delivery time** — the number of days Google waits after purchase
   before emailing the customer to request a review.
6. **Save** the form.

## 2. Confirm the checkout pane

The survey opt‑in is delivered by a checkout pane that is placed automatically on the
**complete** step of your **default** checkout flow. If you use additional or custom
checkout flows, place the Google Customer Reviews pane manually on their complete
step via **Commerce → Configuration → Checkout flows**.

## 3. Place the badge block (optional)

To display your current Google Customer Reviews rating, add the **Google Customer
Reviews Badge** block through **Structure → Block layout**, positioning it in the
region you prefer.

## Data handling and privacy

To fulfil the survey, the module passes **order details — including the customer's
email address and order ID — to Google**. This is an external transfer of personal
data. Make sure your **privacy policy** discloses that purchase information is shared
with Google to enable the reviews survey, in line with the regulations that apply to
your site.

## What to expect after saving

- Nothing will appear on a **local/dev** environment — the badge and survey only
  render on the domain configured in your Merchant profile.
- It can take **up to a week** for the Merchant Center dashboard to show statistics
  and for the integration warning to disappear, and a similar delay before submitted
  reviews appear.
- The badge shows a rating only once enough reviews have been collected for the
  visitor's country — a Google policy.
