# Configuration

Configuring Social Auth Google is two stages: create an OAuth client in Google's
Cloud console, then paste the credentials into the module's settings form.

## Step 1 — create a Google OAuth client

1. In the **Google Cloud console**, create (or reuse) a project and open **APIs &
   Services → Credentials**.
2. Create an **OAuth 2.0 Client ID** of type **Web application**.
3. Set the **Authorized redirect URI** to your site's Social Auth Google
   callback. It looks like
   `https://<your-site>/user/login/google/callback` — the exact path is provided
   by the base Social Auth module and is shown on the module's settings form, so
   copy it from there to be sure.
4. Set the **Authorized JavaScript origin** to your site's origin (e.g.
   `https://<your-site>`).
5. Google gives you a **Client ID** and **Client Secret** — keep them handy for
   the next step.

## Step 2 — enter the credentials in Drupal

1. Go to **Configuration → Social API settings → User authentication → Google**
   (`/admin/config/social-api/social-auth/google`). This is the **Google** tab
   under the Social Auth integrations, and it needs the **Administer social api
   authentication** permission.
2. Fill in the form:
   - **Client ID** — paste the Google OAuth Client ID.
   - **Client Secret** — paste the Google OAuth Client Secret.
   - **Scopes** *(optional)* — extra OAuth scopes, comma‑separated, if you want to
     request access beyond basic login (for example a Google API scope). The
     `openid`, `email`, and `profile` scopes are **always** requested, so you
     don't need to list them.
   - **Endpoints** *(optional)* — extra Google API endpoints to call after login.
   - **Restricted domain** *(optional)* — enter a single Google Workspace domain
     (for example `example.com`) to allow only that organization's Google
     accounts to sign in. Leave it empty to allow any Google account.
3. Click **Save configuration**.

Without a valid Client ID and Secret the Google login button appears but the
OAuth handshake fails, so double‑check they are entered correctly. If a change
doesn't seem to take effect, rebuild caches (`drush cr`).

## What happens next

The Social Auth framework now offers a Google login option in the
login/registration flow. New visitors get a Drupal account created from their
Google profile (name, email), and returning users are matched to their existing
account by email — all handled by the base Social Auth module, not by this one.
You can combine this with other Social Auth providers (Facebook, GitHub, and so
on) to offer several login options side by side.
