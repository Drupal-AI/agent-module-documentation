# Configuration

## Register a VK application

1. Create an application in your VK developer account.
2. Note its **client ID** (application id) and **client secret** (secure key).
3. You will set the application's **Redirect URL** in a moment, once Drupal shows
   you the exact value to use.

## Enter the credentials in Drupal

1. Log in as an administrator.
2. Open Social Auth's network settings for VK, under **Configuration → Social API →
   Social Auth** (route `social_auth.network.settings_form`).
3. Enter the VK **Client ID** and **Client secret**.
4. Note the **Authorized redirect URL** shown on the form.
5. Click to save.

Treat the client secret like a password — keep it in an environment variable / site
secret rather than in exported configuration where practical.

## Point VK back at your site

In the VK application settings, set the **Redirect URL** to the **Authorized
redirect URL** value you copied from the Drupal settings form. This is what lets VK
return the visitor to `/user/login/vk` on your site after they authenticate.

## Show the login button

Go to **Structure → Block Layout** and place a **Social Auth login block**
somewhere on the site (if you have not already). That block renders the
**VKontakte** logo/button. You can alternatively place or theme your own link
pointing to `/user/login/vk`.

## What happens on login

When a visitor clicks the VK link, they are taken to VK to authenticate. VK returns
them to your site; if a Drupal user already exists with the email VK provides, or
the visitor previously registered with VK, they are logged in — otherwise a new
account is created. The random `state` (CSRF) parameter and the code/token exchange
are handled by the Social Auth base, and account creation and matching follow your
Social Auth settings.
