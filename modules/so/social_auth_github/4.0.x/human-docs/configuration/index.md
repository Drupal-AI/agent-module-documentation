# Configuration

Setting up GitHub login is a short round‑trip between Drupal and GitHub: you copy a
redirect URI out of Drupal, register an OAuth app on GitHub, then bring the client
ID and secret back into Drupal. The settings form requires permission to
administer the Social Auth authentication settings.

## 1. In Drupal — copy the redirect URI

1. Log in as an administrator.
2. Go to **Configuration → User authentication → GitHub**.
3. Copy the **Authorized redirect URI** field value. It should end in
   `/user/login/github/callback`.

## 2. In GitHub — register an OAuth app

1. Log in to GitHub and go to **Settings → Developer settings → OAuth Apps**.
2. Click **New OAuth App**.
3. Set the **Application name**, **Homepage URL**, and **Application description**
   as you like.
4. Paste the redirect URI you copied into the **Authorization callback URL**
   field.
5. Click **Register application**.
6. On the new application page, click **Generate a new client secret**.
7. Copy the **client secret** (GitHub only shows it once!) and the **Client ID**,
   and keep them somewhere safe.

## 3. Back in Drupal — enter the credentials

1. Return to **Configuration → User authentication → GitHub**.
2. Enter the GitHub **Client ID** in the **Client ID** field.
3. Enter the GitHub **client secret** in the **Client secret** field. Treat this
   as a secret — keep it out of configuration you commit to a repository.
4. Click **Save configuration**.
5. Go to **Structure → Block Layout** and place a **Social Auth login** block
   somewhere on the site, if one is not already placed.

That's it — log in with a GitHub account to test the implementation.

## Account creation and matching

When GitHub returns a user, the module matches on the GitHub user id or email
address and either logs in the matching account or creates a new one. Whether new
accounts are auto‑created and how existing accounts are matched is governed by the
**Social Auth base module's** settings, so review those to control registration
behaviour — email‑based matching links a GitHub login to any pre‑existing account
with the same address.

## A note on the login entry point

Users can click the GitHub logo in the Social Auth login block, or you can add a
button or link anywhere on the site pointing to `/user/login/github`. The link
route is fixed, so theming and placing the button is entirely up to you.
