# Configuration

Setting up eWeLink has two parts: giving the module your eWeLink **account
credentials** so it can reach the cloud, and deciding **who** is allowed to operate
devices. Because the module can trigger physical actions, the access side deserves as
much attention as the connection side.

## Connect the account

Go to **Configuration → Web Services → eWeLink Settings**
(`/admin/config/ewelink/settings`). Provide the eWeLink OAuth application and account
details the module needs to authenticate to the eWeLink cloud:

- **Region** — the region your eWeLink account is registered in (United States, Europe,
  Asia or China), which selects the correct eWeLink API gateway.
- **App ID** and **App Secret** — the credentials for your eWeLink developer
  application.
- **Redirect URL** — the OAuth redirect URL registered for that application.
- **Email** (and optional **Password**) — your eWeLink account details.

Your eWeLink credentials are secrets: treat the App Secret and account password with
care and only grant the settings form to trusted administrators. Save the form. From
then on the module can reach your devices to trigger actions and read status.

## Gate who can operate devices

This is the most important part. Device actions are gated by permissions and a role:

1. Go to **People → Permissions** and grant **Access the Open the Door page** only to
   the roles that should be able to operate devices. Grant the **Activity** entity
   permissions equally carefully — they control who can see or manage the device
   activity log.
2. Assign the **Open the Door User** role to specific users on **People**
   (`/admin/people`). You can do this by hand, or drive it from custom code (for
   example granting/revoking the role in `hook_cron` or a user-save hook) if access
   should follow some external condition — such as a current booking.

## A note on physical safety

Because opening a door (or switching a device) has real-world consequences, keep the
permission set small and audited, review the Activity log regularly, and make sure the
credentials above are stored securely and rotated if ever exposed. Remember that every
device operation makes an outbound call to the eWeLink cloud.
