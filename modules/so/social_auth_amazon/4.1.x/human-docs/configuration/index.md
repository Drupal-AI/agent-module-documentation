# Configuration

Amazon login needs two things: an application registered on Amazon's side, and its
client ID and secret entered into Drupal's Social Auth settings. All of the Drupal
settings here require the **`administer social api authentication`** permission.

## 1. Register an application with Amazon

On the Amazon developer side, create a "Login with Amazon" application to obtain a
**client ID** and **client secret**. You will need to tell Amazon the **redirect
(callback) URL** for your site — this is the callback provided by the Social Auth
framework. Amazon requires HTTPS, so your site must be served over HTTPS for the
round‑trip to work.

## 2. Enter the credentials in Drupal

In Drupal, go to the **Social Auth** settings and open the **Amazon** network
settings form (under **Configuration → Social API settings → User authentication →
Social Auth**). Enter:

- **Client ID** — the application ID from Amazon.
- **Client secret** — the secret from Amazon. Treat this as a secret: store it
  through the framework's secret handling or the **Key** module rather than
  pasting it into config that gets exported to a repository.

Save the form.

## 3. Show the login entry point

Amazon login can be started in two ways:

- Place the **Social Auth block** (**Structure → Block layout**), which shows an
  **Amazon** button.
- Or add a themed link to **`user/login/amazon`** anywhere on your site.

Clicking either sends the visitor to Amazon; after they authenticate, Social Auth
returns them and either logs them into a matching account or creates a new one.

## Review auto‑registration and account matching

When Amazon returns a user, the module matches on the Amazon user id or email
address. If an account with the same email already exists, that account is used —
so review your Social Auth registration settings to decide whether new accounts
may be auto‑created and how existing accounts are matched, since email‑based
matching links an Amazon login to any pre‑existing account with the same address.

## Security reminders

- Serve the whole flow over **HTTPS**.
- Keep the **client secret** out of exported configuration.
- The OAuth `state`/CSRF validation is handled for you by the Social Auth base
  module's controller, so you do not need to configure it separately.
