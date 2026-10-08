# Configuration

Setting up AddEvent is two stages: first enter your API token, then surface the
calendar widgets wherever you want them (as blocks, or as a field on your content).

## Step 1 — Enter your AddEvent API token

1. Log in as a user with the **Administer addevent settings** permission (an
   administrator by default).
2. Go to **Configuration → Web services → AddEvent settings**, or navigate
   directly to `/admin/config/services/addevent/settings`.
3. Paste your **AddEvent API token** — you get this from your account on
   addevent.com — into the single **Token** field.
4. Click **Save configuration**.

That token is stored in the module's configuration and sent as an `Authorization:
Bearer` header on the module's requests to the AddEvent API over HTTPS. To rotate
the token later, just paste a new one and re-save this form.

> **Keep the token to trusted admins.** Anyone with the *Administer addevent
> settings* permission can read and change the token, so grant that permission
> narrowly.

## Step 2 — Show the calendar widgets

You have two ways to put AddEvent widgets in front of visitors. Use whichever fits.

### Option A — Place a block

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Click **Place block** in the region you want, and choose either the **Add to
   Calendar** block or the **Subscribe to Calendar** block.
3. Configure the block's event details for your use case, set the usual block
   options (title, visibility), and **Save block**.

*Add to Calendar* gives visitors a one-off button to add a single event;
*Subscribe to Calendar* offers a subscription link to a feed that keeps updating.

### Option B — Add the AddEvent field to a content type

1. Go to **Structure → Content types**, pick your event type, and open **Manage
   fields**.
2. Add a field of type **AddEvent**. (Its data-entry widget is hidden — the field
   holds the event data used to build the calendar widget.)
3. Open **Manage display** for that content type and set the AddEvent field's
   format to one of the two formatters:
   - **AddEvent Button** — renders the field as an AddEvent calendar button.
   - **AddEvent Link** — renders it as a plain text link.
4. Save. Each event of that type now shows the AddEvent button or link.

## For developers

If you need to call the AddEvent API from custom code, the module exposes a service
factory, `addevent.api.factory`, that builds an authenticated API client from the
token you saved above. See the agent docs' [api/factory.md](../agent/api/factory.md)
for the details.
