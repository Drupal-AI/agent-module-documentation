# Configuration

Setting up Simplenews has a few distinct parts: creating newsletters, turning a
content type into newsletter issues, letting visitors subscribe, and choosing how
mail is sent. This page walks through each in the order you'd normally do them.

You'll need the relevant permissions — chiefly **Administer newsletters**,
**Administer simplenews settings**, and **Administer simplenews subscriptions**.

## 1. Create newsletters

Go to **Configuration → Web services → Simplenews**
(`/admin/config/services/simplenews`). This lists your newsletters; one default
newsletter exists after install. Add a newsletter for each independent list you
want people to be able to join.

Each newsletter has its own settings, including:

- **Name** and **subject**.
- **Format** — HTML or plain text.
- **From name** and **From address** for outgoing mail.
- **Priority** and **request read receipt**.
- **Allowed recipient handlers** — restrict which recipient handlers this
  newsletter may use (the default handler sends to all active subscribers).

## 2. Turn a content type into newsletter issues

An *issue* is a node. On a content type's edit form, Simplenews adds a control to
attach the **Simplenews issue** field. Enable it on each content type you want to
send newsletters from. Once attached, every node of that type becomes a possible
newsletter issue and gains a **Newsletter** tab for sending.

## 3. Let visitors subscribe

Give people a way to join:

- **Subscription block** — place the *Simplenews subscription* block (for example
  in a sidebar or footer) and pick which newsletters it offers. You can
  pre‑check newsletters, add a message, and include a manage link.
- **Subscriptions page** — `/simplenews/subscriptions` offers a full management
  page (needs the *subscribe to newsletters* permission).
- **User tab** — logged‑in users manage their own subscriptions from a tab on
  their profile.
- **Registration** — you can add newsletter opt‑in checkboxes to the user
  registration form.

Anonymous subscriptions use **double opt‑in**: a hashed confirmation email is
sent, and the subscriber only becomes *active* after they confirm.

## 4. Settings forms

Under the Simplenews section there are three settings forms plus the uninstall
prep form.

### Newsletter settings

Defaults applied to new newsletters and issues, including default **format**,
**priority**, **read receipt**, and whether the token browser is shown on the
node edit form. There is also a hash link **expiration** time controlling how long
confirmation / manage links stay valid.

### Subscription settings

- **Sync fields** between the user account and the subscriber record.
- **Skip verification** — if enabled, anonymous subscribers skip the double
  opt‑in step (not recommended for public sites).
- **Tidy unconfirmed** — automatically delete unconfirmed subscriptions after a
  set number of days (default 7).
- **Confirmation email** subject and body (with tokens), and optional redirect
  pages shown after confirming a subscribe or unsubscribe.

### Send mail settings

This controls the sending model:

- **Use cron** — when on (the default), the mail spool is drained during cron
  runs; when off, Simplenews attempts an immediate batched send.
- **Throttle** — how many mails to send per cron run (default 20). Lower this to
  respect mail‑server limits.
- **Text alternative** — generate a plain‑text version of HTML mail.
- Housekeeping options for how long sent mails are kept in the spool and when
  stuck in‑progress rows are reset, plus a debug logging toggle.

## 5. Send an issue

1. Create a node of your issue content type and write the newsletter content.
2. Open its **Newsletter** tab (`/node/{node}/simplenews`).
3. Optionally **send a test** email to specific addresses first.
4. **Send now** (queues the mails and, with cron sending off, sends immediately)
   or publish/activate the issue to queue it for the next cron runs.

Behind the scenes, sending writes one spool row per recipient; the mailer then
drains the spool immediately or over cron according to your Send mail settings.
You can drain the spool manually from the CLI with `drush simplenews:spool-send`
and check how many mails are pending with `drush simplenews:spool-count`.

## Deploying configuration

Newsletters and settings are configuration, so they export with
`drush config:export` and deploy between environments like the rest of your
config. Subscriber records are content, not config.
