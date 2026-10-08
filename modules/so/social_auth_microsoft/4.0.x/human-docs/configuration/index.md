# Configuration

Setting this module up is a back-and-forth between Drupal and the Azure portal:
Drupal gives you a redirect URL to register with Microsoft, and Microsoft gives
you a client ID and secret to paste back into Drupal.

## 1. Copy the redirect URL from Drupal

1. Log in as an administrator.
2. Go to **Configuration → User authentication → Microsoft**.
3. Copy the **Authorized redirect URL** shown on the form — it ends in
   `/user/login/microsoft/callback`. You'll paste this into Azure in a moment.

## 2. Register an application in Azure

1. Log in to a Microsoft account and open the **Azure Portal**.
2. Go to **App registrations** and click **Register an application**.
3. Give the app a name and pick the account type that suits your audience.
4. Under **Redirect URI**, choose the **Web** platform and paste the redirect URL
   you copied from Drupal in step 1.
5. Click **Register**.
6. On the app's **Overview** page, copy the **Application (client) ID** and keep it
   somewhere safe.
7. Go to **Certificates & secrets → Client secrets** and click **New client
   secret**. Set the fields as you like and click **Add**.
8. Copy the secret from the **Value** column (not the Secret ID column) and store
   it safely — Azure only shows it once.

## 3. Enter the credentials in Drupal

1. Return to **Configuration → User authentication → Microsoft**.
2. Put the Microsoft **Application (client) ID** into the **Client ID** field.
3. Put the Microsoft secret **Value** into the **Client secret** field.
4. Click **Save configuration**.

Treat the client secret like a password. The most robust approach is to keep it in
an environment variable surfaced through a Key entity rather than committing it to
exported configuration.

## 4. Show the login button

Go to **Structure → Block Layout** and place a **Social Auth login block**
somewhere on the site (if you have not already). That block renders the
**Microsoft** button. You can alternatively place or theme your own link pointing
to `user/login/microsoft`.

## Test it

Log out, open the login page, and click **Microsoft**. You should be redirected to
Microsoft to sign in and returned to your site logged in — as a matched existing
account or a freshly created one, depending on your Social Auth settings.
