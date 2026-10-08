# Configuration

Once Smart IP is working, configuring Country Block is quick: grant the permission,
list the countries to block, and write the message blocked visitors see.

## 1. Grant the permission

1. Go to **People → Permissions** (`/admin/people/permissions`).
2. Grant the **Administer Country Block** permission to the appropriate roles (for
   example, Administrator). This controls who can change the blocklist and message.

## 2. Add blocked countries

1. Go to **Configuration → System → Country Block**
   (`/admin/config/system/country-block`).
2. In the **Blocked Countries** text area, enter the two‑letter country codes
   (ISO 3166‑1 alpha‑2) for the countries you want to block — **one code per
   line**. The form links to a list of country codes for reference.

## 3. Set the blocked message

In the **Blocked Message** field, edit the message that will be shown to visitors
from a blocked country. A default message is provided; customize it to suit your
site's tone and to explain (if appropriate) why access is restricted.

## 4. Save

Click **Save configuration**. Country blocking is now active — visitors whose
GeoIP‑resolved country is on your list will be denied access and shown your message.

## Keep the limits in mind

- This is a **best‑effort** gate. GeoIP is approximate, and a VPN or proxy changes a
  visitor's apparent country. Do not rely on it to protect sensitive content or as
  your only access control.
- If your site sits behind a proxy or CDN, make sure Drupal's trusted‑proxy
  settings are configured, or the country detection (and therefore the blocking)
  will be based on the wrong IP address.
- Keep Smart IP's GeoIP database current so detection stays as accurate as the
  method allows.
