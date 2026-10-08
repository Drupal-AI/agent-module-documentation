# Configuration

Configuring iContact Integration has three parts: storing your API credentials
securely, mapping fields and subscription rules, and (optionally) adding the
opt‑in field to your account form. Do the credentials first — nothing can talk to
iContact until they are in place.

## Store your API credentials securely

Your iContact API credentials are **secrets**. Never paste them into a settings
form that gets exported to version‑controlled configuration, and never commit
them to Git. Store them in an environment variable and read them from there.

If you are running DDEV, save the values into DDEV's dotenv file (which you keep
out of version control) and restart so the container picks them up:

```bash
ddev dotenv set .ddev/.env --icontact-app-id=<your-app-id> \
  --icontact-username=<your-username> --icontact-password=<your-password>
ddev restart
```

Each flag becomes an environment variable inside the web container — for example
`--icontact-app-id` becomes `ICONTACT_APP_ID`. You can confirm a variable is
present **without printing its value**:

```bash
ddev exec 'test -n "$ICONTACT_APP_ID" && echo set'
```

The module reads credentials from the environment (or from `settings.php` via
`getenv()`), so once the variables exist in the container the connection can
authenticate. Where the module supports it, you can also route a credential
through a **Key** entity backed by the environment provider — install the Key
module (`drupal/key`) and create a key whose provider is the environment
variable, so the secret is referenced, never stored inline. Keeping the secret in
an environment variable — directly or via a Key — is what keeps it out of your
exported configuration.

## Field mapping and per‑role subscription rules

Open the *User Subscription Configuration* form under **Configuration**. Here you:

- **Map Drupal user fields to iContact contact fields** (and custom fields), so
  the right data lands on each iContact contact.
- **Set a rule for each user role**, independently:
  - **Target mailing list** — which iContact list this role subscribes to.
  - **Subscription trigger** — subscribe when a new account is created, or
    subscribe only when the user explicitly ticks the *iContact Subscribe*
    opt‑in field.
  - **Unsubscribe on delete** — a per‑role toggle that unsubscribes a user from
    the corresponding list when their account is deleted.
  - **Processing weight** — the order roles are processed for a user who holds
    several roles. All active roles are still processed; the weight only sets the
    order, it does not suppress lower‑priority roles.

The module only acts when something actually changes: saving a profile without
touching the opt‑in box creates no queue items and makes no API calls, and
un‑ticking the box on a profile edit cancels any pending subscribe item and
queues an unsubscribe instead — a safety net against accidental double
subscriptions.

## Add the opt‑in field to the account form

If you use the checkbox trigger, add the **iContact Subscribe**
(`icontact_subscribe`) field to the user entity via **Configuration → People →
Account settings → Manage fields**. It renders as an opt‑in checkbox on the
registration and profile‑edit forms, and you can give it any label you like
("Subscribe to our newsletter", "Join the mailing list", and so on).

## The dashboard and the queue

The admin dashboard shows your live iContact mailing lists and the current status
of the `icontact_subscription_queue`. With the queue enabled (the default),
subscription calls run on cron; failed items retry on later runs. To drain the
queue immediately:

```bash
drush queue:run icontact_subscription_queue
```
