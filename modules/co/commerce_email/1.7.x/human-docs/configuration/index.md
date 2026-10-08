# Configuration

Commerce Email has no single settings page. Instead, you create one **email definition**
per notification you want to send, each tied to a store event. All of this lives under the
**Administer commerce_email** permission.

## Open the emails list

1. Log in as a user with the **Administer commerce_email** permission.
2. Go to **Commerce → Configuration → Emails**, or navigate to
   `/admin/commerce/config/emails`.
3. Click **Add email** to create a new definition. Existing definitions can be edited,
   duplicated, enabled/disabled, or deleted from this list.

## Creating an email — field by field

### Event and label

- **Label** — an administrative name to identify this email in the list.
- **Event** — the store event that triggers the email. This is the heart of the
  definition and is **locked once you save**, so choose carefully. Shipped events include:
  - **Order placed** — when a customer places an order (great for order confirmations).
  - **Order paid** — when an order is paid (payment receipts).
  - **Order transition** — a specific order-workflow transition, such as *ship*,
    *fulfill*, or *cancel* (notify the warehouse, send a shipped email, send a
    cancellation).
  - **Checkout registration** / **Checkout completion registration** — when a new account
    is created during checkout (welcome emails).
  - **Payment declined** — for recurring subscriptions, if the Commerce Recurring module
    is installed.

### Recipients

- **Send this email to** — choose how recipients are determined:
  - **A specific email address** — enter one or more addresses in the **To** field. This
    supports tokens, so `[commerce_order:mail]` sends to the order's customer.
  - **Users with a role** — pick a **role**, and the email goes to every user who has it
    (handy for admin or warehouse notifications).
- **From** — the from address; leave blank to use the store's default.
- **Cc**, **Bcc**, **Reply-to** — optional extra addresses; all support tokens. Use Bcc to
  quietly copy an accounting inbox, or Reply-to to route replies to your help desk.

### Message

- **Subject** — the subject line; tokens are allowed, e.g. *"Your order
  [commerce_order:order-number]"*.
- **Body** — the email body, edited with a rich-text format; tokens such as
  `[commerce_order:order-number]` and `[commerce_order:total-price]` personalize the
  message.

### Conditions

- **Conditions** — optional rules that limit when the email sends, using Commerce's
  condition plugins (order total, store, order type, and so on).
- **Condition operator** — choose **AND** (all conditions must match) or **OR** (any one
  matches) when you add more than one.

If you leave conditions empty, the email sends for every occurrence of the chosen event.

### Delivery options

- **Use a queue for sending** — off by default (emails send immediately). Turn it on to
  defer sending to a background queue, which keeps checkout fast for high-volume mail. This
  relies on cron, or on the Advanced Queue module if installed.
- **Log to entity** — when on, each send is recorded on the order's timeline via Commerce
  Log, so staff can see which emails went out.
- **Enabled** — only enabled definitions are considered when an event fires.

## Save and test

Click **Save**, then open the definition's **Test email** tab
(`/admin/commerce/config/emails/{id}/test`) to send a test message and check how the
subject, body, and tokens render before you rely on it in production.

## Multiple emails per event

You can create several enabled emails for the **same** event — for example one order
confirmation to the customer and a separate alert to a warehouse role. Each is evaluated
(conditions and all) and sent independently when the event fires.
