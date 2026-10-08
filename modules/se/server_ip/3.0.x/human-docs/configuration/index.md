# Configuration

Server IP works immediately with a set of default details, but you can choose
extra variables to display and control who is allowed to see them.

## Choose which variables to display

1. Go to **Configuration → Server Settings** (the settings form).
2. The page always shows a set of default details for easy debugging: the
   **database host name**, **database name**, **current theme**, **path to
   theme**, and **base URL**.
3. To show more, tick the **PHP `$_SERVER` variables** you want. The selected
   variables are then displayed on the Server Details page alongside the defaults.
4. Save.

## View the details

Go to **Configuration → Server Settings → Server Details** to see the server's IP
address and everything you selected. On a load-balanced setup, this is where you
confirm which backend answered a given request.

## Control who can see it

The module ships two permissions, found on **People → Permissions**:

- **View Server Details** — who may open the Server Details page and see the
  server IP and other details.
- **Edit Server Settings** — who may change which variables are displayed.

By default the administrator role has access. If you want a different role to see
or edit these pages, grant it the matching permission. Keep this tight: the server
IP and related details are infrastructure information, so limit them to trusted
administrators and never expose backend IPs to the public.
