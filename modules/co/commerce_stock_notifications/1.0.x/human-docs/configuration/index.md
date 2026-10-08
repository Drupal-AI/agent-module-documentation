# Configuration

The module works as soon as it is enabled — out-of-stock products immediately show the
"notify me" field — but you will almost certainly want to adjust the wording of the on-form
text and the email that goes out, and to decide who can manage subscriptions.

## Edit the messages

Go to **Commerce → Configuration → Stock → Stock notifications**
(`/admin/commerce/config/stock/stock-notifications`). All of the text used on the
notification form is editable here — the prompt shown to shoppers on out-of-stock products,
confirmation wording, and the like. Because the module depends on **Token**, you can use
tokens (for example the product title or URL) in the message text so each notification is
specific to the product the shopper asked about.

Save the form when you are done; the new wording takes effect immediately.

## Set permissions

The module provides its own permissions. Go to **People → Permissions**
(`/admin/people/permissions`) and grant the stock-notification permissions to the
appropriate roles — for example, letting staff manage or remove subscription requests.
Review these against your roles so that only trusted users can see or manage the collected
email addresses.

## Manage and unsubscribe subscriptions

- **Logged-in users** can unsubscribe themselves at
  `/user/{user}/stock_notifications`, where each of their requests has an unsubscribe link.
- **Anonymous users** can subscribe but cannot unsubscribe on their own. As an
  administrator you can fetch the unsubscribe link on their behalf from
  `/admin/structure/commerce_stock_notification` and send it to them if they ask to be
  removed.

## How the notification is sent

When a product's stock is replenished (via Commerce Stock), the module notifies everyone
who registered interest in that product. Because the feature collects and stores email
addresses purely to deliver these notifications, treat that data in line with your privacy
policy — capture appropriate consent, and remove requests that are no longer needed.
